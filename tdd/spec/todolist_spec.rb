require_relative "../lib/todoList"
require_relative "../lib/task"
require "spec_helper"

describe TodoList do
	describe "add_task" do
		before :each do
			@todoList=TodoList.new "GOE"
			@task=Task.new(22,"prueba")
		end
		it "create a new task" do
			@todoList.add_task(@task)
			expect(@todoList.list.include?(@task)).to eq(true)
		end
	end
	describe "delete_task" do
		before :each do
			@todoList=TodoList.new "GOE"
			@task=Task.new(22,"prueba")
			@todoList.add_task(@task)
		end
		it "delete task" do
			@todoList.delete_task(22)
			expect(@todoList.list.find{|tasks| tasks.id==22}).to eq(nil)
		end
	end
	describe "find_task_by_id" do
		before :each do
			@todoList=TodoList.new "GOE"
			@task=Task.new(22,"prueba")
			@todoList.add_task(@task)	
		end
		it "find task id not exist" do
			expect(@todoList.find_task(21)).to eq(nil)
		end
		it "find task id that exist" do
			expect(@todoList.find_task(22)).to eq(@task)
		end
	end
	describe "sort" do
		before :each do
			@todoList=TodoList.new "GOE"
			@task=Task.new(22,"prueba 22")
			sleep(3)
			@task2=Task.new(1,"prueba 1")
			@todoList.add_task(@task2)
			@todoList.add_task(@task)	
		end
		it "sort_by_created only one task" do
			expect(@todoList.sort_by_created[0].created_at)==@task.created_at
		end
		it "sort_by_created ASC" do
			copyTodoList=@todoList.list.map{|task| task}
			orderList=@todoList.sort_by_created "ASC"
			copyTodoListOrder=copyTodoList.sort{|task1, task2| task1.id<=>task2.id}
			result=false
			for i in 0..@todoList.list.length-1 do
				result= orderList[i].id==copyTodoListOrder[i].id
			end
			expect(result).to eq(true)
		end
		it "sort_by_created DESC" do
			copyTodoList=@todoList.list.map{|task| task}
			orderList=@todoList.sort_by_created "DESC"
			copyTodoListOrder=copyTodoList.sort{|task1, task2| task2.id<=>task1.id}
			result=false
			for i in 0..@todoList.list.length-1 do
				result= orderList[i].id==copyTodoListOrder[i].id
			end
			expect(result).to eq(true)
		end
	end
end