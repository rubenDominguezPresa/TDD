require_relative "../lib/todoList"
require_relative "../lib/task"
require "spec_helper"

describe TodoList do
	describe "new_task" do
		before :each do
			@todoList=TodoList.new
			@task=Task.new(22,"prueba")
		end
		it "create a new task" do
			expect(@todoList.new_task(@task))==@task
		end
	end
	describe "delete_task" do
		before :each do
			@todoList=TodoList.new
		end
		it "delete task" do
			@todoList.new_task(@task)
			expect(@todoList.delete_task(22))==22
		end
	end
	describe "complete_task" do
		before :each do
			@todoList=TodoList.new
			@task = Task.new(22,"prueba")
		end
		it "complete? task false" do
			@todoList.new_task(@task)
			expect(@todoList.complete?(@task)).to eq(false)
		end
		it "complete? task true" do
			@todoList.new_task(@task)
			@todoList.complete!(@task)
			expect(@todoList.complete?(@task)).to eq(true)
		end
		it "complete? task true to false" do
			@todoList.new_task(@task)
			@todoList.complete!(@task)
			@todoList.complete!(@task)
			expect(@todoList.complete?(@task)).to eq(false)
		end
	end
end