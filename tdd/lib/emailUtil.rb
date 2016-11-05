class EmailUtil
	def initialize emails=[]
		@emails=emails
	end
	def find_subject email, subject
		result =false
		subject.each do |subject|
			result = @emails.each{|mail| mail[0]==email ? mail[0].include?(subject) : false}
		end
		result
	end
end