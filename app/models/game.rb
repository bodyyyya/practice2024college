class Game < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_one_attached :image

  has_many :cart_items, dependent: :destroy

  settings index: {
    analysis: {
      analyzer: {
        default: {
          type: 'standard'
        }
      }
    }
  } do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: 'standard'
      indexes :description, type: :text, analyzer: 'standard'
    end
  end

  def as_indexed_json(options = {})
    as_json(only: [:title, :description])
  end
end

# Ensure the index is created and data is imported
Game.__elasticsearch__.create_index! force: true
Game.import
