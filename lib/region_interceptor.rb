require 'region_interceptor/version'

module RegionInterceptor
  class Railtie < ::Rails::Railtie
    rake_tasks do
      load 'tasks/region_interceptor.rake'
    end
  end
end
