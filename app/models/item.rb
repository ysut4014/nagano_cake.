class Item < ApplicationRecord
    has_one_attached :image
    belongs_to :genre
    has_many :other_model_records, dependent: :destroy
end
