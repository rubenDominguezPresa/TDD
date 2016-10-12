class Post

	attr_reader :title
	attr_reader :date
	attr_reader :text
	attr_reader :sponsored
	def initialize(title,date,text,sponsored=false)
		@title=title
		@date=date
		@text=text
		@sponsored=sponsored
	end


end

#class blog 
class Blog
	require 'colorize'
	attr_reader :arrayPosts
	def initialize
		@arrayPosts=[]
	end
	#addpost in blog
	def addPost(post)
		@arrayPosts.push(post)
	end

	#print post with format 
	def publish_front_page(paginationArrayPost)
		paginationArrayPost=paginationArrayPost.sort {|post1, post2| post2.date<=>post1.date}
		paginationArrayPost.each do |post|
			if (post.sponsored)
				puts "*********#{post.title}************ \n***************\n#{post.text}\n---------------"
				
			else
				puts "#{post.title} \n***************\n#{post.text}\n---------------"
			end
		end
	end

	#method to paginate in the array of post
	def pagination(numPag=0)
		system("clear")
		paginationArray=[]
		for i in numPag*3..((numPag*3)+2)
			if (i<@arrayPosts.size)
				paginationArray.push(@arrayPosts[i])
			end
		end
		publish_front_page(paginationArray)
		printPaginationMenu(numPag)
	end

	#print the pagination menu
	def printPaginationMenu(numPag)
		numPages=(@arrayPosts.size/3.to_f).ceil
		for i in 1..numPages
			if(i==numPag+1)
				print "#{i} ".red
			else
				print "#{i} "
			end
		end
		puts
		if(numPag!=0)
			print "< prev       "
		end
		if(numPag<numPages-1)
			print "> next"
		end
		puts
		step=gets.chomp
		if (step=="next")
			pagination(numPag+1)
		elsif (step=="prev")
			pagination(numPag-1)
		else
			return
		end
	end
end

blog=Blog.new
blog.addPost(Post.new("Post 1","20-3-2016","ñdlkfñldfkñldsfkñsdlfk"))
blog.addPost(Post.new("Post 2","22-3-2016","ñdlkfñldfkñldsfkñsdlfk"))
blog.addPost(Post.new("Post 3","25-3-2016","ñdlkfñldfkñldsfkñsdlfk",true))
blog.addPost(Post.new("Post 4","27-3-2016","ñdlkfñldfkñldsfkñsdlfk"))
blog.addPost(Post.new("Post 5","20-2-2016","ñdlkfñldfkñldsfkñsdlfk"))
blog.addPost(Post.new("Post 6","2-1-2016","ñdlkfñldfkñldsfkñsdlfk",true))
blog.addPost(Post.new("Post 7","27-1-2016","ñdlkfñldfkñldsfkñsdlfk"))
blog.addPost(Post.new("Post 8","20-1-2016","ñdlkfñldfkñldsfkñsdlfk"))
blog.pagination()