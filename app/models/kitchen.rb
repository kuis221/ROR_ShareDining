class Kitchen
  include Mongoid::Document
  # for created_at and updated_at fields
  include Mongoid::Timestamps
  include Mongoid::Token
  include Mongoid::Paperclip

  # https://github.com/meskyanichi/mongoid-paperclip
  embeds_many :pictures, :cascade_callbacks => true

  # Foreign key to User
  belongs_to :user

  # Token serves as a unique kitchen id
  token :length => 6, :retry_count => 3

  field :title,                           type: String
  field :description,                     type: String
  field :rental_space,                    type: String

  # Inventory Questionnaire
  field :washing_station,                 type: Array, default: []
  field :food_preparation,                type: Array, default: []
  field :cookware,                        type: Array, default: []
  field :storage,                         type: Array, default: []
  field :refrigeration,                   type: Array, default: []
  field :ovens_fryers,                    type: Array, default: []
  field :oven_equipment_and_storage,      type: Array, default: []
  field :baking_and_pastry,               type: Array, default: []
  field :other_equipment,                 type: Array, default: []
  field :other_amenities,                 type: Array, default: []

  # Information Questionnaire
  # TODO: possibly make this location an object?
  field :location,                        type: String

  # TODO: insert photos...

  field :kitchen_rules_and_instructions,  type: String, default: ""
  # TODO: decide object to hold kitchen availability
  field :availability,                    type: String
  field :price,                           type: Integer
  field :additional_details,              type: String, default: ""

  validates_presence_of :title, :description, :rental_space, :location, :price

  # Enforces index on database
  # TODO: decide what fields will be queried often
  # Can also index on User's attributes with `index "user.<attribute>" => 1`
  index({ token: 1 }, { unique: true, name: "token_index" })

end