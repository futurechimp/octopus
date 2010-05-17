require File.dirname(__FILE__) + '/../helper'
require 'em-spec/test'

class Grabbers::GenericHttpTest <  Test::Unit::TestCase

  include EventMachine::TestHelper

  context "A generic http grabber instance" do
    setup do
      em do
        @grabber = Grabbers::GenericHttp.new
        done
      end
    end

    should "set its '@@currently_encoding' property to false on initialization" do
      assert_equal Grabbers::GenericHttp.currently_encoding, false
    end

    should "be able to check on its expired resources" do
      assert @grabber.respond_to?("check_expired_resources")
    end

#    context "with a changed resource" do
#      setup do
#        @expired_resource = NetResource.make(:next_update => Time.now - 10, :)
#      end
#
#      should "update changed resource" do
#
#      end
#    end


  end

end

