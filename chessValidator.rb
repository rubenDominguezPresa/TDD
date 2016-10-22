require 'pry'

class ChessValidator
	def initialize
		@board=Board.new
		@pieceTypes={"wP"=> "P", "bP"=> "P","wR"=> "R", "bR"=> "R","wN"=> "N", "bN"=> "N","wB"=> "B", "bB"=> "B","wQ"=> "Q", "bQ"=> "Q","wK"=> "K", "bK"=> "K"}
		@coordToArray=CoordToArray.new
		
		#arrayMoves.each {|piece| }
	end
	def check_move origin, destiny
		puts coorOrigin=@coordToArray.translate(origin)
		puts coorDestini=@coordToArray.translate(destiny)
		puts name=@pieceTypes[@board.getPiece(coorOrigin)]
		
		if (@board.getPiece(coorDestini))
			puts Piece.move?(coorOrigin,coorDestini,name)
		else
			puts "invalid"   		
		end
	end
end

class Board
	def initialize
		@board=FileUtilities.read_file "board.txt"
	end
	def setPice #coordx, Coordy
		#@board[coordx][coory]=type
	end
	def getPiece coord 
		@board[coord[0]][coord[1]]
	end
end

class Piece
	def initialize
		@color
		@type
	end
	def self.move? origin, destiny, name
		case name
			when "P"
				Pawn.valid_moves(origin, destiny)
			when "R"
				Rook.valid_moves(origin, destiny)
			when "N"
				Knight.valid_moves(origin, destiny)
			when "B"
				Bishop.valid_moves(origin, destiny)
			when "Q"
				Queen.valid_moves(origin, destiny)
			when "K"
				King.move(origin destiny)
		end
	end
	
	def valid_moves origin, destiny
		puts "prueba"
	end
end
class Moves
	def self.horizontal? origin, destiny
		if (origin[0]==destiny[0])
			((destiny[1]>origin[1])||(destiny[1]<origin[1]))	
		end 
	end

	def self.vertical? origin, destiny
		if (origin[1]==destiny[1])
			((destiny[0]>origin[0])||(destiny[0]<origin[0]))	
		end
	end

	def self.diagonal? origin, destiny
		compare1=origin[0]-destiny[0]
		compare2=origin[1]-destiny[1]
		compare1 < 0 ? compare1=compare1*-1 : ""
		compare2 < 0 ? compare2=compare2*-1 : ""
		compare1==compare2
	end

end

class Rook < Piece
	def self.valid_moves origin, destiny
		(Moves.horizontal?(origin,destiny)) || (Moves.vertical?(origin,destiny))
	end
end

class Bishop < Piece
	def self.valid_moves origin, destiny
		Moves.diagonal? origin, destiny
	end
end

class Queen < Piece
	def self.valid_moves origin, destiny
		((Moves.vertical? origin, destiny) || (Moves.horizontal? origin, destiny) || (Moves.diagonal? origin, destiny)) 
	end
end

class Knight < Piece
	def self.valid_moves origin, destiny
		#((Moves.horizontal?(origin, destiny)) && (Moves.vertical?(origin, destiny)))
		#Moves.diagonal? origin, destiny
	end
end

class Pawn < Piece
	def self.valid_moves origin, destiny
		((Moves.vertical?) && ((origin[0]+1)==destiny[0]))
	end
end

class King < Piece
	def self.valid_moves origin, destiny
		if Queen.valid_moves(origin,destiny)
			compare1=origin[0]-destiny[0]
			compare2=origin[1]-destiny[1]
			compare1 < 0 ? compare1=compare1*-1 : ""
			compare2 < 0 ? compare2=compare2*-1 : ""
			compare1-compare2==1 
		end
	end
end

class CoordToArray
	def initialize
		@corAH=Hash.new
		b=0
		for i in "a".."h"
			@corAH.store(i, b)
			b=b+1
		end
	end

	def translate coord
		return [@corAH[coord[0]],(coord[1].to_i-1)]
	end
end

class FileUtilities
	def self.read_file file
		arrayReg=[]
		File.open(file) do |reg|
		 	reg.each_line {|line|  arrayReg << line.split}
		end
		return arrayReg
	end
end

#FileUtilities.read_file "board.txt"

ChessValidator.new.check_move("a1","a2")

