require 'pry'
require 'colorize'
require_relative "cell"
class Grid
	def initialize size
		@grid=Array.new(size[0]){Array.new(size[1],0)}
		for i in 0..@grid.size-1
			for j in 0..@grid[i].size-1
				@grid[i][j]=Cell.new(rand(0..1),[0,0,0,0,0,0,0,0])	
			end
		end
	end
	def getNeighStatus position
		neigh_status=[]
		x=position[0]
		y=position[1]
		neigh_status << ((x-1>=0 && y-1>=0) ? (@grid[x-1][y-1].state) : 0)
		neigh_status << ((x-1>=0) ? (@grid[x-1][y].state) : 0)
		neigh_status << ((x-1>=0 && y+1<@grid[0].size) ? (@grid[x-1][y+1].state) : 0)
		neigh_status << ((y-1>=0) ? (@grid[x][y-1].state) : 0)
		neigh_status << ((y+1<@grid[0].size) ? (@grid[x][y+1].state) : 0)
		neigh_status << ((x+1<@grid.size && y-1>=0) ? (@grid[x+1][y-1].state) : 0)
		neigh_status << ((x+1<@grid.size && y+1<@grid[0].size) ? (@grid[x+1][y+1].state) : 0)
		neigh_status << ((x+1<@grid.size) ? (@grid[x+1][y].state) : 0)
	end
	def updateCellsState
		for i in 0..@grid.size-1
			for j in 0..@grid[i].size-1
				cell=@grid[i][j]
				cell.neighbours=getNeighStatus([i,j])	
			end
		end
	end
	
	def nextGeneration
		for i in 0..@grid.size-1
			for j in 0..@grid[i].size-1
				cell=@grid[i][j]
				cell.regenerate	
			end
		end
		updateCellsState
		for i in 0..@grid.size-1
			for j in 0..@grid[i].size-1
				cell=@grid[i][j]
				cell.born	
			end
		end
		for i in 0..@grid.size-1
			for j in 0..@grid[i].size-1
				cell=@grid[i][j]
				cell.die	
			end
		end
		updateCellsState
	end
	def printCells
		sleep(1)
		system("clear")
		for i in 0..@grid.size-1
			for j in 0..@grid[i].size-1
				cell=@grid[i][j]
				cell.state==1 ? ( print "O".green) : (print "*".red)	
			end
			puts
		end
	end
	def livedCells
		count=0
		for i in 0..@grid.size-1
			for j in 0..@grid[i].size-1
				cell=@grid[i][j]
				cell.state==1 ? count +=1 : count +=0	
			end
		end
		count
	end
	def play
		updateCellsState
		while (livedCells>0)
			printCells
			nextGeneration
		end
	end

end

Grid.new([3,100]).play