#
# Often times you will want to have a class hold configuration details. A typical way
# to do that in Ruby would be to:
#
# App.configure do |config|
#   config.name       = "My App"
#   config.api_key    = "123"
#   config.api_secret = "abc"
# end
#
# NOTES:
#
#
#
module Configurable

  #
  # allows the passing of whatever attrs that are needed
  #
  def self.with_attrs(*attrs)

    # create our config class to hold config details
    config_klass = Class.new { attr_accessor *attrs }

    #
    # Define an anonymous module to set and save config details
    #
    module_methods = Module.new do

      #
      # config method for instantiating the +config_klass+ and retrieving it's details
      #
      define_method :config do
        @config ||= config_klass.new
      end

      #
      # configuration block for setting the config details
      #
      def configure(&block)
        yield(config) if block_given?
      end
    end

    #
    # self.included method
    #
    Module.new do
      singleton_class.send(:define_method, :included) do |klass|
        klass.extend module_methods
      end
    end

  end # with_attrs

end
