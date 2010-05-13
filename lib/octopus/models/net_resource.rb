# Some kind of resource which we're watching for changes out on the interweb.
# Could be an RSS feed, a web page, etc.
#
class NetResource
  include DataMapper::Resource

  # Properties
  #
  property :id,         Serial
  property :url,        String,  :required => true, :length => (1..254)
  property :last_modified_hash, Integer
  property :update_period, Integer, :required => true, :default => 1200
  property :next_update, DateTime, :required => true, :default => Time.now
  property :last_updated, DateTime
  property :body, Text
  property :created_at, DateTime
  property :updated_at, DateTime

  # Associations
  #
  has n, :subscriptions

  # Validations
  #
  validates_with_method :url, :method => :validate_url
  validates_with_method :update_period, :method => :validate_update_period

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

  # Returns an array of all resources which have a next_update time which is
  # less than or equal to Time.now.
  #
  def self.expired
    all(:next_update.lte => Time.now)
  end

  # Sets the next_update time equal to the current time plus the update_period
  # for this resource.
  #
  def set_next_update
    self.next_update = Time.now + update_period
    self.save
  end

  # Ensures that the update_period is not less than 20 seconds.
  #
  def validate_update_period
    unless self.update_period.nil? || self.update_period < 20
      return true
    else
      [false, "Update period must be more than 20 seconds"]
    end
  end

end

