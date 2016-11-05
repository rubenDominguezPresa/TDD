require_relative "../lib/todoList"
require_relative "../lib/task"
require "spec_helper"

describe Task do
	describe "complete_task" do
		before :each do
			#@todoList=TodoList.new
			@task = Task.new(22,"prueba")
			#@todoList.new_task(@task)
		end
		it "complete? task false" do
			expect(@task.complete?).to eq(false)
		end
		it "complete! task true" do
			expect(@task.complete!).to eq(true)
		end
		it "make_incomplete! task true to false" do
			@task.complete!
			@task.make_incomplete!
			expect(@task.complete?).to eq(false)
		end
	end
	describe "update_content" do
		before :each do
			#@todoList=TodoList.new
			@task = Task.new(22,"prueba")
			#@todoList.new_task(@task)
		end
		it "update content to 'prueba modificada'" do
			expect(@task.update_content("")).to eq(false)
		end
		it "update content to 'prueba modificada'" do
			@task.update_content("prueba modificada")
			expect(@task.taskName).to eq("prueba modificada")
		end
		it "update content to 'prueba modificada' update time" do
			@task.update_content("prueba modificada")
			expect(@task.updated_at)==Time.now
		end
	end
end