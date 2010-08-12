require File.dirname(__FILE__) + '/helper'

class NetResourceTest <  Test::Unit::TestCase

  context "A NetResource instance" do

    should "validate the url" do
      resource = ::NetResource.new
      assert !resource.valid?
      resource.url = "http://foo.com/blah.rss"
      assert resource.valid?
      resource.url = "foo"
      assert !resource.valid?
    end

    should "have a working subscription association" do
      resource = ::NetResource.new
      assert resource.respond_to?("subscriptions")
      subscription = ::Subscription.new(:url => "http://example.org/notify")
      assert_nothing_raised do
        resource.subscriptions << subscription
      end
      assert_equal resource.subscriptions.first, subscription
    end

    should "not have an update period less than twenty seconds" do
      resource = ::NetResource.new(:url => "http://foo.bar.org")
      resource.update_period = 19
      assert !resource.valid?
      resource.update_period = 20
      assert resource.valid?
    end

    should "set its update period" do
      resource = ::NetResource.new(:url => "http://foo.bar.org")
      resource.update_period = nil
      assert !resource.valid?
    end

    should "have a next_update method" do
      resource = NetResource.new
      assert resource.respond_to?("set_next_update")
    end

    should "be able to set its next update period correctly" do
      resource = ::NetResource.new(:url => "http://foo.bar.org")
      resource.save!
      resource.set_next_update
      assert_equal Time.parse(resource.next_update.to_s), Time.parse((Time.now + resource.update_period).to_s)
    end

    should "have an 'expired' method" do
      assert ::NetResource.respond_to?("expired")
    end
  end

  context "The NetResource class" do
    should "have an 'expired' named scope" do
      # First, set all existing resources to expire tomorrow and give them a
      # next_update time of 20 seconds.
      ::NetResource.all.each do |resource|
        resource.next_update = Time.now + 24*60*60
        resource.update_period = 20
        resource.save!
      end
      assert_equal 0, ::NetResource.expired.length

      resource = ::NetResource.new(:url => "http://foo.bar.org")
      resource.update_period = 20
      resource.next_update = Time.now - 25
      resource.save!
      assert_equal 1, ::NetResource.expired.length
      resource.set_next_update
      assert_equal 0, ::NetResource.expired.length
    end
  end
end

