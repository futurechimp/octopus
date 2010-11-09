require File.dirname(__FILE__) + '/helper'

class SubscriptionTest <  Test::Unit::TestCase

  context "A Subscription instance" do

    setup do
      @resource = ::NetResource.new(
        :url => "http://example.org/foo.rss",
        :update_period => 25)
      @resource.subscriptions << Subscription.new(
        :url => "http://example2.org/callback")
      @subscription = ::Subscription.new
    end

    should "validate the url" do
      @subscription.net_resource = @resource
      assert !@subscription.valid?
      @subscription.url = "http://foo.com/notify"
      @subscription.save!
      assert @subscription.valid?
      @subscription.url = "foo"
      assert !@subscription.valid?
      @subscription.url = "https://foo.bar.org"
      assert @subscription.valid?
      @subscription.url = "mailto:foo@bar.org"
      assert !@subscription.valid?
    end

    should "have a working association with net resource" do
      assert @subscription.respond_to?("net_resource")
      assert_nothing_raised do
        @subscription.net_resource = @resource
      end
    end

    should "be invalid unless it belongs to a NetResource" do
      @subscription.url = "http://example.org/foo"
      assert !@subscription.valid?
      @subscription.net_resource = @resource
      @subscription.save!
      assert @subscription.valid?
    end

  end

end

