require 'csv'
require 'rails'
ActiveRecord::Base.logger = Logger.new(STDOUT)

namespace :region_interceptor do
  task seed: :environment do
    seed_models = %w(region prefecture area city)
    import_csv(seed_models)
  end

  task update: :environment do
    seed_models = %w(region prefecture area city)
    import_csv(seed_models, type: :update)
  end

  def import_csv(models, type: :seed)
    models.each do |model|
      next if model.classify.constantize.all.present? && type.to_sym == :seed
      CSV.read("./db/fixtures/csv/#{model}.csv", headers: true, row_sep: :auto).each do |data|
        attributes = data.to_hash
        next unless attributes['name']
        object = model.classify.constantize.find_or_initialize_by(id: attributes.delete('id'))
        object.update attributes
      end
    end
  end
end