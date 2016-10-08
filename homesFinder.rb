	class Home
		attr_reader(:name, :city, :capacity, :price)

		def initialize(name, city, capacity, price)
			@name = name
			@city = city
			@capacity = capacity
			@price = price
		end
	end

	homes = [
		Home.new("Nizar's place", "San Juan", 2, 42),
		Home.new("Fernando's place", "Seville", 5, 47),
		Home.new("Josh's place", "Pittsburgh", 3, 41),
		Home.new("Gonzalo's place", "Málaga", 2, 45),
		Home.new("Ariel's place", "San Juan", 4, 49),
		Home.new("Pepitos's place", "San Juan", 7, 52),
		Home.new("Luis's place", "Seville", 2, 57),
		Home.new("nano's place", "Pittsburgh", 3, 51),
		Home.new("hugo's place", "Málaga", 2, 55),
		Home.new("Iria's place", "San Juan", 4, 59)
	]

	def printResultsHomes(fhomes)

		fhomes.each{|hm| puts "#{hm.name} #{hm.city} #{hm.capacity} #{hm.price}"}
	end

	def findCity(city, fhomes) 
		return fhomes.select{|hm| hm.city==city.to_s}
		
	end

	def orderBy(order,fhomes)

		if order.to_s=="price"
			return fhomes.sort{|hm1,hm2| hm1.price<=>hm2.price}
		elsif order.to_s=="capacity"
			return fhomes.sort{|hm1,hm2| hm1.capacity<=>hm2.capacity}
		else
			return fhomes
		end
	end


	def findPrice(price,fhomes)
		resultFind=fhomes.find{|hm| hm.price==price}
		puts "#{resultFind.name} #{resultFind.city} #{resultFind.capacity} #{resultFind.price}"
	end

	def printAverage(fhomes)
		prices=fhomes.map{ |hm| hm.price}
		total=fhomes.reduce(0.0) {|sum,hm| sum+hm.price}
		puts "Average: #{total/prices.length}"
	end

	def main(homes)
		printResultsHomes(homes)
		homesFilter=homes
		puts "find city?"
		findCity=gets.chomp
		if findCity=="yes"
			puts "City: "
			city=gets.chomp
			homesFilter=findCity(city,homesFilter)	
			printResultsHomes(homesFilter)
		end
		puts "order by price or by capacity: "
		order=gets.chomp
		printResultsHomes(orderBy(order,homesFilter))
		printAverage(homesFilter)
		puts "find by price: "
		price=gets.chomp.to_i
		findPrice(price,homesFilter)
	end

	main(homes)
