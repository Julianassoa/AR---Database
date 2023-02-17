require 'byebug'
require_relative '../models/post'
require_relative '../views/posts_view'

class PostsController
  def initialize
    @view = PostsView.new
  end

  ################################################################
  # BEWARE: you MUST NOT use the global variable DB in this file #
  ################################################################

  def index
    post = Post.all
    @view.list(post)
  end

  def create
    # gets the information from  the view regarding the answers title and url
    # method add in view returns an hash so no need to convert it by calling our
    # hash builder method
    post_info = @view.add_to_db
    # feeds the constructor with post_info (hash)
    new_post = Post.new(post_info)
    # save the new instance
    new_post.save
  end

  def update
    # display all the available posts before updating
    # for a cleaner approach and user friendly
    index
    # ask the user the ID from the view. Result is an hash
    id_info = @view.update_the_db
    # request the find id method from the model to initiate the constructor
    # Post.find takes a parameter which must not be a string hence we access the key value
    find_id = Post.find(id_info[:id])
    # request title and url information from user
    title_url_info = @view.add_to_db
    # Build an hash with all information to feed later into the constructor
    full_info = { "id" => id_info[:id].to_i,
                  "title" => title_url_info[:title],
                  "url" => title_url_info[:url] }
    # request the constructor by feeding the full info hash into our hash builder method
    # byebug
    updated_post = Post.build_record(full_info)
    # save the updated posts
    updated_post.save
  end

  def destroy
    # display all the available posts before destroying
    # for a cleaner approach and user friendly
    index
    # ask the user the ID from the view. Result is an hash
    id_info = @view.destroy_from_db
    # call the find method from the model
    find_id = Post.find(id_info[:id])
    # call the destroy method from the model
    find_id.destroy
  end

  def upvote
    # display all the available posts before voting
    index
    # ask the user the ID to upvote
    id_info = @view.upvote
    # find the post from the db
    updated_post = Post.find(id_info[:id])
    # increment the vote
    updated_post.votes += 1
    # save
    updated_post.save
  end
end
