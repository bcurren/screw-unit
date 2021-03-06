module ScrewUnit

  def self.configure(&block)
    Configuration.instance.instance_eval(&block)
  end

  class Configuration
    class << self
      def instance
        @instance ||= new
      end

      def method_missing(method, *args, &block)
        instance.send(method, *args, &block)
      end
    end

    attr_reader :base_path

    def load_screwrc(base_path)
      @base_path = base_path
      load("#{base_path}/.screwrc")
    end
    
    def port(port=nil)
      @port = port if port
      @port
    end

    def code_under_test_path(relative_path=nil)
      @code_under_test_path = expand_path(relative_path) if relative_path
      @code_under_test_path
    end

    def specs_path(relative_path=nil)
      @specs_path = expand_path(relative_path) if relative_path
      @specs_path
    end

    def screw_unit_core_path
      File.expand_path("#{File.dirname(__FILE__)}/../../javascript/lib")
    end

    def sprockets_enabled(enabled=nil)
      @sprockets_enabled = enabled unless enabled.nil?
      @sprockets_enabled
    end

    def custom_resource_locators
      @custom_resource_locators ||= []
      @custom_resource_locators
    end

    def register_custom_resource_locator(klass)
      @custom_resource_locators ||= []
      @custom_resource_locators << klass
    end

    def expand_path(relative_path)
      File.expand_path("#{base_path}/#{relative_path}")
    end
  end
end