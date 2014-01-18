class Search
  include Mongoid::Document
  field :q, type: String
end
