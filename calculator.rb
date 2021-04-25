# Utils

class Result
  attr_reader :value, :error

  def initialize(error: nil, value: nil)
    @error = error
    @value = value
  end

  def success?
    error.nil?
  end
end

# Logic

require "bigdecimal/util"

module Calculator
  AMOUNT_FMT = /\A\d+(\.\d{1,2})?\z/

  class Amount
    def initialize(raw_amount)
      @amount = raw_amount.to_d
    end

    def to_s
      @amount.to_s("F")
    end
  end

  def self.compute(raw_amount)
    if raw_amount !~ AMOUNT_FMT
      Result.new(error: "Le format du montant est invalide")
    else
      amount = Amount.new(raw_amount)
      Result.new(value: amount)
    end
  end
end

# View

require 'markaby/kernel_method'

class Calculator::View
  def initialize(raw_amount: "", result: nil, error: nil)
    @raw_amount = raw_amount
    @result = result
    @error = error
  end

  def to_html
    mab _form: form, _result: result do
      html do
        head do
          title "Greta - Price calculator"
        end
        body do
          h1 "Greta - Price calculator"
          text _form
          text _result
        end
      end
    end
  end

  private

  def form
    mab raw_amount: @raw_amount do
      form method: "POST", action: "/" do
        input name: "raw_amount", value: raw_amount, placeholder: "Prix"
        button type: "submit" do
          "Valider"
        end
      end
    end
  end

  def result
    mab result: @result, error: @error do
      if result
        dl.result do
          dt "Résultat :"
          dd result
        end
      elsif error
        dl.error do
          dt "Erreur :"
          dd error
        end
      end
    end
  end
end

# Routing

require "sinatra/base"

class Calculator::App < Sinatra::Base
  get "/" do
    Calculator::View.new.to_html
  end

  post "/" do
    raw_amount = params.fetch("raw_amount")
    result = Calculator.compute(raw_amount)
    Calculator::View.new(
      raw_amount: params["raw_amount"],
      result: result.value,
      error: result.error,
    ).to_html
  end
end
