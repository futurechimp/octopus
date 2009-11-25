require File.dirname(__FILE__) + '/helper'

class OctopusTest <  Test::Unit::TestCase

  def setup
    clear_database
  end

  context "on GET to / without credentials" do
    setup do
      get '/'
    end

    should "respond" do
      assert !last_response.ok?
      assert_equal 401, status
    end
  end

  context "on GET to / with credentials" do
    setup do
      get '/', {}, basic_auth_creds

      should "respond" do
        assert last_response.ok?
      end
    end
  end

  context "on GET to /new with credentials" do
    setup do
      get '/new', {}, basic_auth_creds
    end

    should "respond" do
      assert last_response.ok?
    end
  end

  context "on GET to /edit with credentials" do
    setup do
      n = NetResource.make
      get "/edit/#{n.id}", {}, basic_auth_creds
    end

    should "respond" do
      assert last_response.ok?
    end
  end

  context "POST to create" do
    num_resources = NetResource.count
    num_subscriptions = Subscription.count
    n = NetResource.plan
    s = Subscription.plan

    context "without credentials" do
      setup do
        post '/create', {:net_resource => n, :subscription => s}
      end
      should "respond with a 401 unauthorized" do
        assert !last_response.ok?
        assert_equal 401, status
      end
    end

    context "with a valid new NetResource" do
      setup do
        num_resources = NetResource.count
        num_subscriptions = Subscription.count
        post '/create', {:net_resource => NetResource.plan, :subscription => Subscription.plan}, basic_auth_creds
        follow_redirect!
      end

      should "redirect" do
        assert_equal "http://example.org/", last_request.url
        assert_equal num_resources + 1, NetResource.count
        assert_equal num_subscriptions + 1, Subscription.count
      end
    end

    context "for an existing NetResource" do
      setup do
        n = NetResource.make
        s = Subscription.plan
        num_resources = NetResource.count
        num_subscriptions = Subscription.count
        post '/create', {:net_resource => {:url => n.url, :update_period => 20}, :subscription => s}, basic_auth_creds
        follow_redirect!
      end

      should "redirect" do
        assert_equal "http://example.org/", last_request.url
        assert_equal num_resources, NetResource.count
        assert_equal num_subscriptions + 1, Subscription.count
      end
    end
  end

  def test_new_or_edit_for_new_resource
    post '/new_or_edit', {:net_resource => {
      :url => "http://news.bbc.co.uk/foo/bar/#{DateTime.now.to_s}/blah.rss"
      }}, basic_auth_creds
    follow_redirect!
    assert_equal "http://example.org/new", last_request.url
  end

  def test_new_or_edit_for_existing_resource
    NetResource.make
    post '/new_or_edit', {:net_resource => {
      :url => NetResource.first.url
      }}, basic_auth_creds
    follow_redirect!
    assert_equal "http://example.org/edit/#{NetResource.first.id}", last_request.url
  end

  def test_update
    n = NetResource.make
    put "/update/#{n.id}", {:id => n.id, :net_resource => {:update_period => 666}}, basic_auth_creds
    follow_redirect!
    assert_equal "http://example.org/", last_request.url
    assert_equal NetResource.first.update_period, 666
  end

  def test_bad_update_redisplays
    NetResource.make
    NetResource.first.update(:update_period => 60)
    put "/update/#{NetResource.first.id}", {:net_resource => {:update_period => 10}}, basic_auth_creds
    assert last_response.ok?
    assert_equal "http://example.org/update/#{NetResource.first.id}", last_request.url
    assert_equal NetResource.first.update_period, 60
  end

  private

  def clear_database
    NetResource.all.each { |n| n.destroy }
    Subscription.all.each { |s| s.destroy }
  end

end

