require_relative '../lib/bloc_works.rb'
require "rack/test"
require 'test/unit'

class BlocWorksTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    BlocWorks::Application.new
  end

  def test_favicon
    get '/favicon.ico'
    assert_equal last_response.status, 404
  end
end
