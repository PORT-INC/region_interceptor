require 'rails'
require 'open3'

module RegionInterceptor

  class UpdateGenerator < ::Rails::Generators::Base
    source_root File.expand_path('../../templates', __FILE__)

    def update_csv
      %w(region prefecture area city).each do |name|
        remove_file "csv/#{name}.csv"
        copy_file "csv/#{name}.csv", "#{Rails.root}/db/fixtures/csv/#{name}.csv"
      end
    end
  end
end