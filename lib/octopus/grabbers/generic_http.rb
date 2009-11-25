module Grabbers
  class GenericHttp

    include EM::Protocols

    # Adds a periodic timer to the Eventmachine reactor loop and immediately
    # starts grabbing expired resources and checking them.
    #
    def initialize
      @@currently_encoding = false
      puts "Initializing generic http grabber..."
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
        uri = URI.parse(resource.url)
        conn = HttpClient2.connect uri.host, uri.port

        req = conn.get(uri.path)
        req.callback{ |response|
          resource.set_next_update
          if resource_changed?(resource, response)
            notify_subscribers(resource)
            update_changed_resource(resource, response)
          end
        }
      end
    end

    # Notifies each of a NetResource's subscribers that the resource has changed
    # by doing an HTTP GET request to the subscriber's callback url.
    #
    def notify_subscribers(resource)
      resource.subscriptions.each do |subscription|
        uri = URI.parse(subscription.url)
        conn = HttpClient2.connect uri.host, uri.port
        req = conn.get(uri.path)
      end
    end

    # Determines whether a resource has changed by comparing its saved hash
    # value with the hash value of the response content.
    #
    def resource_changed?(resource, response)
      changed = false
      if response.content.hash != resource.last_modified_hash
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
      resource.last_modified_hash = response.content.hash
      resource.last_updated = Time.now
      resource.body = response.content
      resource.save
    end

  end
end

