require_relative "../lib/fizz_buzz"

require "spec_helper"

describe "fizz_buzz" do
it "3 prints FIZZ" do
    expect(FizzBuzz.new.pr(3)).to eq("FIZZ")
  end
end