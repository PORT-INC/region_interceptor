require 'rails'
require 'open3'

module RegionInterceptor

  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def create_regions
      Open3.capture3('bundle exec rails g model region name:string code:string')
    end

    def create_prefectures
      Open3.capture3('bundle exec rails g model prefecture name:string code:string region:references')
    end

    def create_cities
      Open3.capture3('bundle exec rails g model city name:string prefecture:references')
    end

    def copy_csv
      %w(region prefecture city).each do |name|
        copy_file "csv/#{name}.csv", "#{Rails.root}/db/fixtures/csv/#{name}.csv"
      end
    end
  end
end