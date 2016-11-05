class Task
	attr_reader :id, :created_at
	attr_accessor :complete, :taskName, :updated_at
	def initialize id, taskName
		@id=id
		@taskName=taskName
		@complete=false
		@created_at= Time.now
		@updated_at= Time.now
	end
	def complete?
		#binding.pry
		@complete 
	end
	def complete!
		@complete=true
		#task.complete=task.complete ? false : true
		#task.complete
	end
	def make_incomplete!
		@complete=false
		#task.complete=task.complete ? false : true
		#task.complete
	end
	def update_content content
		if(content.size>0)
			@taskName=content
			@updated_at=Time.now
		else
			false
		end
	end
end