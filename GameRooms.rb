require 'pry'

class Player
	attr_accessor :position, :lifes
	def initialize(position=0, lifes=0)
		@position=position
		@lifes=lifes
		@items=[]
	end
	def openDoor(step)
		case (step)
		when "E"
			@position=@position+1
		when "W"
			@position=@position-1
		when "N"
			@position=@position+10
		when "S"
			@position=@position-10
		end
	end
	def takeItem(item)
		@items<<item
		puts "you take #{item}"
	end
	def haveItem?(item)
		@items.include? item
	end
	def dropItem(item)
		@items.delete(item)
		puts "you drop #{item}"
	end
	def printInventory
		@items.each{|item| puts "#{item}"}
	end
end

class Room
	attr_reader :description, :position, :items, :endRoom 
	attr_accessor :doors
	def initialize description="", valid=false, endRoom=false, doors=[], items=[], position 
		@description=description
		@doors=doors
		@position=position
		@items=items
		@endRoom=endRoom
	end
	
	def printDescription
		print "#{@description} "
	end

	def printDoors
		@doors.include?("N") ? (print ". There is a door at the North. ") : ""
		@doors.include?("S") ? (print ". There is a door at the South. ") : ""
		@doors.include?("W") ? (print ". There is a door at the West. ") : ""
		@doors.include?("E") ? (print ". There is a door at the East. ") : ""
	end

	def printItems
		@items.each{|item| item!=nil ? (puts "You can see a #{item}") : (puts "")}
	end

	def isValidDoor?(door)
		@doors.include? door
	end

	def isLastRoom?
		@endRoom
	end
	def existItem?(item)
		@items.include? item
	end

	def takeItem(item)
		@items<<item
	end

	def dropItem(item)
		@items.delete(item)
	end

end

class Map
	attr_accessor :map
	attr_reader :initRoom
	def initialize(numRooms, items, descriptions)
		@map=Hash.new
		@initRoom=rand(numRooms-1)
		@items=items
		@map[@initRoom]=Room.new("You are in the forest.",true,false,[],[],[@initRoom])
		i=0
		actualRoom=@initRoom
		while (i<numRooms-2)
			puts actualRoom
			item=nil
			if(rand(2)==0) 
				item=@items.items[rand(@items.items.length-1)]
				@items.items.delete(item)
			else
			end
			actualRoom=addRamdomRoom(actualRoom.to_i,descriptions.descriptions[rand(descriptions.descriptions.length)],[item])
			i=i+1
		end
		addRamdomRoom(actualRoom.to_i,"You are in the final room. Congrats",[],true)
	end

	def addRamdomRoom(actualPosition, description, item=[],endRoom=false)
		find=false
		while(!find)
			nextCuad=rand(4)
			puts nextCuad
			case(nextCuad.to_i)
				when 0
					if(!@map[actualPosition+1])
							#E
							@map[actualPosition+1]=Room.new(description,true,endRoom,["W"],item,[actualPosition+1])			
							find=true
							@map[actualPosition].doors.push("E")							
							return actualPosition+1
						else
							@map[actualPosition+1].doors.push("W","E")
							actualPosition=actualPosition+1
						end

				when 1

					if (!@map[actualPosition-1])
						@map[actualPosition-1]=Room.new(description,true,endRoom,["E"],item,[actualPosition-1])
						#W
						find=true
						#binding.pry
						@map[actualPosition].doors.push("W")
						return actualPosition-1
					else
						@map[actualPosition-1].doors.push("E","W")
						actualPosition=actualPosition-1
					end


				when 2
					#binding.pry
					
					if (!@map[actualPosition+10])
						@map[actualPosition+10]=Room.new(description,true,endRoom,["S"],item,[actualPosition+10])
						#N
						find=true
						@map[actualPosition].doors.push("N")
						return actualPosition+10
					else
						@map[actualPosition+10].doors.push("S","N") 
						actualPosition=actualPosition+10
					end


				when 3

					if (!@map[actualPosition-10])
						@map[actualPosition-10]=Room.new(description,true,endRoom,["N"],item,[actualPosition-10])
						#S
						find=true
						@map[actualPosition].doors.push("S")
						return actualPosition-10
					else
						@map[actualPosition-10].doors.push("N","S")
						actualPosition=actualPosition-10
					end

				end
			end
		end

		def getRoom(position)
			@map[position]
		end
	end

		class Game
			attr_accessor :rooms_descriptions, :items, :gameMap, :player
			def initialize
				@items=Items.new
				@rooms_descriptions=RoomsDescriptions.new
				@gameMap=Map.new(10,@items,@rooms_descriptions)
				@player=Player.new(@gameMap.initRoom, 3)
				@gameStatus=SaveGameStatus.new
			end

			def printGameStatus
				if(@player.lifes.to_i>0)
					@gameMap.getRoom(@player.position).printDescription
					@gameMap.getRoom(@player.position).printDoors
					@gameMap.getRoom(@player.position).printItems
				else
					puts "no more lifes"
				end
			end

			def gameNavigation
				system("clear")
				while (!(@gameMap.getRoom(@player.position).isLastRoom?) && @player.lifes.to_i > 0)
					printGameStatus
					puts ">"
					command=gets.chomp.to_s
					action(command)
				end
				printGameStatus
				puts
			end
			def action(command)
				case (command)
				when "N","S","W","E"
					if(@gameMap.getRoom(@player.position).isValidDoor?(command))
						@player.openDoor(command)
					else
						puts "invalid door. you lose 1 life"
						@player.lifes=@player.lifes-1
					end	
				when /TAKE/
					item=(command.split)[1]
					if(@gameMap.getRoom(@player.position).existItem?(item))
						@player.takeItem(item)
						@gameMap.getRoom(@player.position).dropItem(item)
					else 
						puts "object not found"
					end
				when /DROP/
					item=(command.split)[1]
					if(@player.haveItem?(item))
						@player.dropItem(item)
						@gameMap.getRoom(@player.position).takeItem(item)
					else 
						puts "object not found"
					end
				when /INVENTORY/
					@player.printInventory
				when /SAVE/
					@gameStatus.save(@gameMap,@player)
					puts ("Game status saved OK")
				when /LOAD/
					@gameMap=@gameStatus.load(@gameMap,@player)[0]
					@player=@gameStatus.load(@gameMap,@player)[1]
					system("clear")
					puts ("Game load OK")
				else
					puts ("invalid command, the commands are N, S, E, W, TAKE item, DROP item, INVENTORY ,SAVE, LOAD")
				end
			end
		end

		class Items
			attr_accessor :items
			def initialize
				@items=["SWORD","KEY","CANDLE","BOOK"]
			end
		end

		class RoomsDescriptions
			attr_accessor :descriptions
			def initialize
				@descriptions=["You are in a dark room.",
					"You are in a dark room.There is a lot of light.",
					"You are in the forest. There is a lot of ligh.",
					"You are in a light room."]
				end
		end

		class SaveGameStatus
			def initialize 
				
				#game_map.each {|room| puts "#{room}"}
			end
			def save game_map, player
				saveData=[]
				saveData.push(game_map)
				saveData.push(player)
				IO.write("saveFile.log",Marshal.dump(saveData)) 
				#(game_map.map.collect {|key,room| "[#{key}, #{room.description}, #{room.doors}, #{room.position}, #{room.items}, #{room.endRoom}]"})	
			end
			def load game_map, player
				saveData=[]
				load=IO.read("saveFile.log")
				saveData=Marshal.load(load)
				return saveData
			end
		end

	Game.new.gameNavigation