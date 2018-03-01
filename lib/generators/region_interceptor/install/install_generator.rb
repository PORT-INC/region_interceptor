require 'rails'
require 'open3'

module RegionInterceptor

  class InstallGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def create_regions
      Open3.capture3('bundle exec rails g model region name:string code:string')
      puts 'region.rb is created!'
    end

    def create_prefectures
      Open3.capture3('bundle exec rails g model prefecture name:string code:string region:references')
      puts 'prefecture.rb is created!'
    end

    def create_areas
      Open3.capture3('bundle exec rails g model area name:string code:string prefecture:references')
      puts 'area.rb is created!'
    end

    def create_cities
      Open3.capture3('bundle exec rails g model city name:string code:string area:references')
      puts 'city.rb is created!'
    end

    def copy_csv
      %w(region prefecture area city).each do |name|
        copy_file "csv/#{name}.csv", "#{Rails.root}/db/fixtures/csv/#{name}.csv"
      end
    end
  end
end