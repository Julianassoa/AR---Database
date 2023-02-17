class Post
  # TODO
  attr_reader :id
  attr_accessor :title, :url, :votes

  def initialize(properties = {})
    @id = properties[:id]
    @title = properties[:title]
    @url = properties[:url]
    @votes = properties[:votes] || 0
  end

  def self.build_record(attributes)
    post_attributes = {
      id: attributes["id"],
      title: attributes["title"],
      url: attributes["url"],
      votes: attributes['votes']
    }
    Post.new(post_attributes)
  end

  def self.find(id)
    # id must be an integer dont make the mistake to pass a string into it
    DB.results_as_hash = true
    # array of hashes
    query_attributes = DB.execute("SELECT * FROM posts WHERE id = ?", id).first
    # make the exit condition in case query_hash returns an empty array
    # which means the database doesn't have that id record
    # returns an hash
    # if query_completed execute the constructor
    build_record(query_attributes) if query_attributes
  end

  def self.all
    DB.results_as_hash = true
    # this tests if the DB is empty or not.
    if ::DB.execute("SELECT * FROM posts").empty?
      []
    # the else part should map the array of hashes
    else
      # converts the array of hashes into hashes by feeding the hash converted method
      ::DB.execute("SELECT * FROM posts").map do |post|
        # called self.build record and passing the result of map into the attributes
        # raise post.inspect
        # byebug
        build_record(post)
      end
    end
  end

  def save
    # if its empty create a record
    if @id.nil?
      # insert title
      DB.execute("INSERT INTO posts (title, url, votes) VALUES (?, ?, ?)", @title, @url, @votes)
      # check last id in case its the first record created
      @id = DB.last_insert_row_id
    else
      # else just update it
      DB.execute("UPDATE posts SET title == ?, url == ?, votes == ? WHERE id == ?", @title, @url, @votes, @id)
    end
  end

  def destroy
    # TODO: destroy the current instance from the database
    DB.execute("DELETE FROM posts WHERE id = #{id}")
  end
end
