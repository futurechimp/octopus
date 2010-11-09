module Grabbers
  class Feedzirra < Grabbers::GenericHttp

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

  end
end

