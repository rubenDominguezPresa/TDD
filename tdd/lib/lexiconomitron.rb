class Lexiconomitron
	def eat_t phrase
		phrase.delete! "t"
		phrase.delete! "T"
		phrase
	end
	def shazam phrase
		result=[]
		phrase.each {|word| result << eat_t(word.reverse)}
		[result[0],result[result.length-1]]
	end
	def oompa_loompa phrase
		result=[]
		phrase.each {|word| word.size<=3 ? result << eat_t(word) : ""}
		result
	end
end