require "rspec"

require "active_record"

ActiveRecord::Base.establish_connection(
  adapter:  'sqlite3',
  database: 'db.sqlite3',
)

ActiveRecord::Schema.define do
  create_table :tests, force: true do |t|
    t.string :name
    t.integer :age
    t.float :price
  end
end

require_relative "../../../../app/models/user"
require_relative "../../../../app/models/test"
require_relative "../../../../app/concepts/test/operation/create"

RSpec.describe Test::Create do
  let (:anonymous) { User.new(false) }
  let (:signed_in) { User.new(true) }
  let (:pass_params) { { test: { name: "Hola", age: "22", price: "27.99" } } }

  it "save_test" do
    result = Test::Create.(pass_params, "current_user" => signed_in)

    expect(result).to be_truthy
    expect(Test.last).not_to be_nil
  end
end
