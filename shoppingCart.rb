class Cart
	attr_reader :cart
	
	def initialize
		@cart=Hash.new
		@prices=Prices.new
		@totalCart=0
	end
	def add_item item
		@cart.include?(item) ? @cart.store(item,@cart[item]+1) : @cart.store(item,1)  
	end

	def remove_item item

	end

	def view_cart
		@cart.select do |item,num| 
			puts "#{num} #{item}: #{(@prices.get_price item)*num}$"
			@totalCart=@totalCart+@prices.get_price(item)*num
		end
		puts "Total: #{@totalCart}"
		totalCartDiscount=Discounts.calculate(@cart, @prices, @totalCart)
		@cart.select{|item,num| puts "#{@cart[item]} #{item}"}
		puts "Total with discounts: #{totalCartDiscount}$"
	end
end

class Items
	
	def initialize 
		@items = {apple: 10, banana: 20, oranges: 5, grapes: 15, watermelon: 50}
	end
	def addItem cod, name
		
	end
end

class Prices
	def initialize
		@prices={apple: 10, banana: 20, oranges: 5, grapes: 15, watermelon: 50}
	end
	def spring_prices
		@prices={apple: 10, banana: 20, oranges: 5, grapes: 15, watermelon: 50}
	end
	def get_price item
		@prices[item]
	end
end

class Discounts
	def self.calculate cart, prices, totalCart
		@cartDiscount=cart
		@totalCart=totalCart
		discount_apples cart,prices
		discounts_oranges cart,prices
		discounts_grapes cart
		return @totalCart
	end
	def self.discount_apples cart, prices
		discount=cart[:apple] ? (cart[:apple]>=2 ? (cart[:apple]/2*prices.get_price(:apple)) : 0) : 0
		if (discount>0)
			puts "discount, 2x1 in apples: -#{discount}$"   
			@totalCart=@totalCart-discount
		end
	end

	def self.discounts_oranges cart,prices
		discount=cart[:oranges] ? (cart[:oranges]>=3 ? (cart[:oranges]/3*prices.get_price(:oranges)) : 0) : 0
		if (discount>0)
			puts "discount, 3x2 in oranges: -#{discount}$"
			@totalCart=@totalCart - discount
		end
	end

	def self.discounts_grapes cart
		discount=cart[:grapes] ? (cart[:grapes]>=4 ? (cart[:grapes]/4) : 0) : 0
		discount>0 ? (puts "gift x4 grapes: #{discount} bananas") : ""
		@cartDiscount.store(:banana, @cartDiscount.include?(:banana) ? (discount=discount+@cartDiscount[:banana]) : discount)
	end	
end



cart = Cart.new
cart.add_item :apple
cart.add_item :apple
cart.add_item :oranges
cart.add_item :oranges
cart.add_item :oranges
cart.add_item :oranges
cart.add_item :grapes
cart.add_item :grapes
cart.add_item :grapes
cart.add_item :grapes
cart.view_cart
