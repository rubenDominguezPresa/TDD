class Player
	attr_accessor :position, :lifes
	def initialize(position, lifes)
		@position=position
		@lifes=lifes
	end
end

class Room
	attr_reader :description
	def initialize description, doors='end'
		@description=description
		@doors=doors
	end
	
	def printDescription
		print "#{@description}  "
	end

	def printDoors
		print @doors
	end
 	
 	def isValidDoor(door)
 		@doors.include? door
 	end

 	def isLastRoom
 		@doors.include? 'end'
 	end
end

class Map
	attr_reader :map
	def initialize
		#for i=0..numRooms-1
			@map=[]
			@map << Room.new("init",['s'])
			@map << Room.new("room door",['s'])
			@map << Room.new("room door",['s'])
			@map << Room.new("room door",['e'])
			@map << Room.new("room door",['e'])
			@map << Room.new("room door",['n'])
			@map << Room.new("last room")
	end
	def getRoom(position)
		@map[position]
	end
	def nextRoom(room,door)
		room=room+1
	end
end

class Game
	def initialize
		@player=Player.new(0, 3)
		@gameMap=Map.new
	end

	def printGameStatus
		if(@player.lifes.to_i>0)
			@gameMap.getRoom(@player.position).printDescription
			@gameMap.getRoom(@player.position).printDoors
		else
			puts "no more lifes"
		end
	end

	def gameNavigation
		system("clear")
		while ((!@gameMap.getRoom(@player.position).isLastRoom) && @player.lifes.to_i > 0)
			printGameStatus
			puts ">"
			if @gameMap.getRoom(@player.position).isValidDoor(gets.chomp.to_s)
				nextRoom()	
			else
				puts "invalid door"
				@player.lifes=@player.lifes-1
			end
		end
		printGameStatus
		puts
	end

	def nextRoom()
		@player.position=@gameMap.nextRoom(@player.position,"S")
	end
end

Game.new.gameNavigation

