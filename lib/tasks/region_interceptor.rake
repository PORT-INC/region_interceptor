require 'csv'
require 'rails'
ActiveRecord::Base.logger = Logger.new(STDOUT)

Module.new do
  extend Rake::DSL

  namespace :region_interceptor do
    desc '地域・都道府県・エリア・市区町村を作成する'
    task seed: :environment do
      seed_models = %w(region prefecture area city)
      import_csv(seed_models)
    end

    desc '地域・都道府県・エリア・市区町村を更新する'
    task update: :environment do
      seed_models = %w(region prefecture area city)
      import_csv(seed_models, type: :update)
    end

    def self.import_csv(models, type: :seed)
      models.each do |model|
        next if model.classify.constantize.all.present? && type.to_sym == :seed
        CSV.read("./db/fixtures/csv/#{model}.csv", headers: true, row_sep: :auto).each do |data|
          attributes = data.to_hash
          next unless attributes['name']
          object = model.classify.constantize.find_or_initialize_by(id: attributes.delete('id'))

          # 失敗したら重複を見つけて、別の値に上書きしてからまたupdate
          unless object.update(attributes)
            duplication = model.classify.constantize.where(attributes)
            duplication.each_with_index do |dup, index|
              dup.assign_attributes(name: "#{attributes['name']}_#{index}", code: "#{attributes['code']}_#{index}")
              dup.save
            end
            object.update(attributes)
          end
        end
      end
    end
  end
end
