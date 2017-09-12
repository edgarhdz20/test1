require "reform"
require "reform/form/dry"

module Test::Contract
  class Create < Reform::Form
    include Dry

    property :name
    property :age
    property :price

    validation do
      required(:name).filled
      required(:age).maybe(min_size?: 1)
      required(:price).maybe(min_size?: 0)
    end
  end
end
