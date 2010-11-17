module Grabbers
  class GenericHttp

    include EM::Protocols

    # Adds a periodic timer to the Eventmachine reactor loop and immediately
    # starts grabbing expired resources and checking them.
    #
    def initialize
      EM.add_periodic_timer(5) {
        check_expired_resources
      }
      check_expired_resources
    end

    # Gets all of the expired NetResources from the database and sends an HTTP
    # GET requests for each one.  Subscribers to a NetResource will be notified
    # if it has changed since the last time it was grabbed.
    #
    def check_expired_resources
      net_resources = ::NetResource.expired
      net_resources.each do |resource|
        http = EM::HttpRequest.new(resource.url).get

        http.callback{ |response|
          resource.set_next_update
          if resource_changed?(resource, response)
            notify_subscribers(resource)
            update_changed_resource(resource, response)
          end
        }
        http.errback {|response|
          # Do something here, maybe setting the resource
          # to be not checked anymore.
        }
      end
    end

    # Notifies each of a NetResource's subscribers that the resource has changed
    # by doing an HTTP GET request to the subscriber's callback url.
    #
    def notify_subscribers(resource)
      resource.subscriptions.each do |subscription|
        http = EM::HttpRequest.new(subscription.url).post(:body => {:data => resource.body})
        http.callback{ |response|
          puts "found updated data for #{resource.url}, #{resource.body.length} characters"
        }
        http.errback {|response|
          # Do something here, maybe setting the resource
          # to be not checked anymore.
        }
      end
    end

    # Determines whether a resource has changed by comparing its saved hash
    # value with the hash value of the response content.
    #
    def resource_changed?(resource, response)
      changed = false
      puts "checking for changes on #{resource.url}"
      puts "response.response.hash: #{response.response.hash}"
      puts "resource.last_modified_hash: #{resource.last_modified_hash}"
      if response.response.hash != resource.last_modified_hash
        puts "changed!!!!\n\n\n\n"
        changed = true
      end
    end

    # Updates the resource's fields when the resource has changed.  The
    # last_modified_hash is set to the hash value of the response body, the
    # response body itself is saved so that it can be sent to consumers during
    # notifications, and the resource's last_updated time is set to the current
    # time.
    #
    def update_changed_resource(resource, response)
      resource.last_modified_hash = response.response.hash
      resource.last_updated = Time.now
      resource.body = response.response
      resource.save
    end

  end
end

