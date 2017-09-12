require "trailblazer"
require_relative "../contract/create"

class Test::Create < Trailblazer::Operation
  step Policy::Guard( :authorize! )
  step :model!
  step Contract::Build( constant: Test::Contract::Create )
  step Contract::Validate( key: :test )
  step :persist!
  step :notify!

  def authorize!(options, current_user:, **)
    current_user.signed_in?
  end

  def model!(options, **)
    options["model"] = Test.new
  end

  def persist!(options, params:, model:, **)
    model.save
  end

  def notify!(options, current_user:, model:, **)
    puts "Se guardo :D"
  end
end

