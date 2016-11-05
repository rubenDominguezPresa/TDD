require 'pry'
require "task"

class TodoList
	attr_reader :list
	def initialize user
		@list=[]
		@user=user
	end
	def add_task task 
		@list << task
		@list[@list.length]
	end
	def delete_task id
		task=@list.find{|tasks| tasks.id==id}
		@list.delete(task)
	end
	def find_task id
		@list.find{|tasks| tasks.id==id}
	end
	def sort_by_created order="ASC"
		sorted_tasks=[]
		if order=="ASC"
			sorted_tasks = @list.sort { | task1, task2 | task1.id <=> task2.id }
		elsif order=="DESC"
			sorted_tasks = @list.sort { | task1, task2 | task2.id <=> task1.id } 
		end
		sorted_tasks
	end
end