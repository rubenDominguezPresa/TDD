require_relative "../lib/emailUtil"
require "spec_helper"

class Subjects
	def initialize
		@emailList=[["test@test.com","subejct tests 1 goe"],["test@test.com","subject test 2 with goe"]]
	end
	def get_subject
		@emailList
	end
end

describe EmailUtil do 
	describe "#find_subject" do
		let (:fake_subjects) {Subjects.new.get_subject}

		it "get subjects of an email" do
			expect(EmailUtil.new(fake_subjects).find_subject("test@test",["goe"])).to eq(true)
		end
	end
end
