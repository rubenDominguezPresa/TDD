class Post
	require 'date'

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

class Blog
	require 'date'
	def initialize
		@arrayPosts=[]
	end

	def addPost(post)
		@arrayPosts.push(post)
	end

	def publish_front_page
		@arrayPosts=@arrayPosts.sort {|post1, post2| post2.date<=>post1.date}
		@arrayPosts.each do |post|
		 	if (post.sponsored)
		 		puts "*********#{post.title}************ \n***************\n#{post.text}\n---------------"
		 	
		 	else
		 		puts "#{post.title} \n***************\n#{post.text}\n---------------"
			end
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
blog.publish_front_page