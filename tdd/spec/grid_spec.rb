require "pry"
class Grid
	def initialize size
		@grid=Array.new(size[0],Array.new(size[1],0))
		live_cells=rand(size[0]**size[1])
		while live_cells>0
			x=rand(size[0])
			y=rand(size[1])
			if @grid[x][y]==0 
				@grid[x][y]= Cell.new(1,[0,0,0,0,0,0,0,0])
				live_cells -=1
			end
		end
	end
	def getNeighStatus position
		neigh_status=[]
		neigh_status << @grid[position[0]-1][position[1]-1]
		neigh_status << @grid[position[0]-1][position[1]]
		neigh_status << @grid[position[0]-1][position[1]+1]
		neigh_status << @grid[position[0]][position[1]-1]
		neigh_status << @grid[position[0]][position[1]+1]
		neigh_status << @grid[position[0]+1][position[1]-1]
		neigh_status << @grid[position[0]+1][position[1]+1]
		neigh_status << @grid[position[0]+1][position[1]]

	end

	def firstUpdateCellsState
		for i in 0..@grid.size-1
			for j in 0..@grid[i].size-1
				binding.pry
				cell=@grid[i][j]
				cell==1 ? cell.neighbours=getNeighStatus[i,j]  : 0	
			end
		end
	end
end
Grid.new([3,3]).firstUpdateCellsState
#describe Grid do 
#


#end
