# A url callback pointing to a web application or messaging system which wants
# to be notified about changes to a NetResource.
#
class Subscription
  include DataMapper::Resource

  # Properties
  #
  property :id,         Serial
  property :url,        String,  :required => true, :length => (1..254)
  property :created_at, DateTime
  property :updated_at, DateTime

  # Associations
  #
  belongs_to :net_resource

  # Validations
  #
  validates_with_method :validate_url
  validates_presence_of :net_resource

  # Checks that the url property is formatted correctly.
  #
  def validate_url
    begin
      uri = ::URI.parse(self.url)
      if uri && uri.scheme == "http" || uri.scheme == "https"
        return true
      else
        return [false, "Url must be properly formatted"]
      end
    end
    rescue ::URI::InvalidURIError
  end

end

