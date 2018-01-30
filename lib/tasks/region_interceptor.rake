require 'csv'
require 'rails'
ActiveRecord::Base.logger = Logger.new(STDOUT)

namespace :region_interceptor do
  task seed: :environment do
    seed_models = %w(region prefecture city)
    seed_models.each do |model|
      next if model.classify.constantize.all.present?
      CSV.read("./db/fixtures/csv/#{model}.csv", headers: true, row_sep: :auto).each do |data|
        attributes = data.to_hash
        next unless attributes['name']
        object = model.classify.constantize.find_or_initialize_by(id: attributes.delete('id'))
        object.update attributes
      end
    end
  end
end