require_relative "test_helper"
require_relative "../configuration/configurable"

class TestDummy
  include Configurable.with_attrs(:app_name, :api_key, :api_secret)
end

class ConfigurableTest < Minitest::Test

  def app_name
    "Test App"
  end

  def key
    "123"
  end

  def secret
    "abc"
  end

  def test_name
    TestDummy.configure do |config|
      config.app_name   = app_name
      config.api_key    = key
      config.api_secret = secret
    end

    assert_equal TestDummy.config.app_name,    app_name
    assert_equal TestDummy.config.api_key,     key
    assert_equal TestDummy.config.api_secret,  secret
  end

end
