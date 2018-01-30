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
        object = model.classify.constantize.find_or_initialize_by(id: attributes.delete('id'))
        object.update pref_name_to_id(attributes)
      end
    end
  end

  # 市町村と都道府県のデータは総務省のサイトに依存 http://www.soumu.go.jp/denshijiti/code.html
  def pref_name_to_id(attributes)
    return attributes unless attributes.has_key?('pref_name')
    id = Prefecture.find_by(name: attributes.delete('pref_name')).id
    attributes.tap { |me| me['prefecture_id'] = id }
  end
end