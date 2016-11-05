require_relative "../lib/lexiconomitron"
require "spec_helper"

describe Lexiconomitron do 
  describe "#eat_t" do
    it "removes every letter t from the input" do
      @lexi = Lexiconomitron.new
      expect(@lexi.eat_t("great scott!")).to eq("grea sco!")
    end
  end

  describe "shazam" do
  		before :each do
  			@lexi = Lexiconomitron.new
  		end

  		it "reverses the letters within the words" do
  			expect(@lexi.shazam(["is", "is", "a", "boring"])).to eq(["si", "gnirob"])
  		end

  		it "reverses the letters within the words and eat t" do
  			expect(@lexi.shazam(["this", "is", "a", "boring", "test"])).to eq(["sih", "se"])
  		end

  		it "reverses the letters within the words and eat T" do
  			expect(@lexi.shazam(["This", "is", "a", "boring", "TesT"])).to eq(["sih", "se"])
  		end
  end

  describe "oompa_loompa" do
  	before :each do
  		@lexi = Lexiconomitron.new
  	end

  	it "takes the ones which size is three characters of less in the same order" do
  		expect(@lexi.oompa_loompa(["if", "you", "wanna", "be", "my", "lover"])).to eq(["if", "you", "be", "my"])
  	end
  	it "takes the ones which size is three characters of less in the same order and eat t" do
  		expect(@lexi.oompa_loompa(["it", "you", "wanna", "bet", "my", "lover"])).to eq(["i", "you", "be", "my"])
  	end
  	it "takes the ones which size is three characters of less in the same order and eat T" do
  		expect(@lexi.oompa_loompa(["iT", "you", "wanna", "be", "my", "lover"])).to eq(["i", "you", "be", "my"])
  	end
  end

end