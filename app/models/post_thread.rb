class PostThread
  include Mongoid::Document
  store_in collection: 'threads' 
  
  field :tid, type: Integer
  field :name, type: String
  field :uid, type: Integer
  field :postcount, type: Integer
  field :lastposttime, type: DateTime
end
