class PostsView
  # TODO: implement methods called by the PostsController
  def list(posts)
    # "Displaying all meals available"
    # try to build a to_s method
    posts.each do |post|
      puts "ID: #{post.id} NAME: #{post.title} URL: #{post.url} VOTES: #{post.votes}"
    end
  end

  def add_to_db
    puts 'Please give us the name of the post'
    print '> '
    answer_one = gets.chomp
    puts 'Please give us the URL of the post'
    print '> '
    answer_two = gets.chomp
    { title: answer_one, url: answer_two }
  end

  def update_the_db
    puts "This is all our available posts"
    puts "Please tell us the ID so we can update without fuckups"
    answer_three = gets.chomp
    { id: answer_three }
  end

  def destroy_from_db
    puts "This is all our available posts"
    puts "Which mofo you wanna DESTROY FOR EVAH?!? EVAH? EVAH EVAH? - Kayne West"
    answer_four = gets.chomp
    { id: answer_four }
  end

  def upvote
    puts "Which post you wanna shill so badly?"
    answer_five = gets.chomp
    { id: answer_five }
  end
end
