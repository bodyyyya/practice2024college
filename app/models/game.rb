class Game < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  settings do
    mappings dynamic: false do
      indexes :title, type: :text, analyzer: 'english'
      indexes :description, type: :text, analyzer: 'english'
    end
  end

  def as_indexed_json(options = {})
    as_json(only: [:title, :description])
  end
end

# Ensure the index is created and data is imported
Game.__elasticsearch__.create_index!
Game.import