require 'imdb'
class ReadMoviesFile
	def self.read file
		arrayMovies=[]
		File.open(file) do |movie|
		 	movie.each_line {|movie| arrayMovies << movie}
		end
		return arrayMovies

	end
end

class ImdbMovies
	def self.find_movie movie
		Imdb::Search.new(movie).movies[0]
	end	
	def self.movie_rate movie
		find_movie(movie).rating
	end
end

class Main
	def self.movie_rating(moviesFile)
		system("clear")
		movieArray=[]
		movies=ReadMoviesFile.read(moviesFile)
		movies.each {|movie| movieArray << ImdbMovies.movie_rate(movie)}
		PrintRatings.print_Vertical movieArray
		PrintRatings.print_horizontal movieArray
		puts
		puts
		PrintRatings.print_movie_list movies
	end
end

class PrintRatings
	def self.print_Vertical movieRatingArray
		maxRating=movieRatingArray.max.to_i
		for i in 0..maxRating
			movieRatingArray.each{|rating| rating.to_i>=maxRating ? (print "|#|") : (print "| |")}
			maxRating=maxRating-1
			puts ""
		end
	end

	def self.print_horizontal movieRatingArray
		movieRatingArray.each{|rating| print "---"}
		puts
		num=0
		movieRatingArray.each{|rating| print "|#{num=num+1}|"}
	end

	def self.print_movie_list movieArray
		num=0
		movieArray.each{|movie| puts "#{num=num+1}. #{movie}"}
	end
end
Main.movie_rating "movies.txt"
