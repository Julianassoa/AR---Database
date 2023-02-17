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

  def destroy
    # TODO: destroy the current instance from the database
    DB.execute("DELETE FROM posts WHERE id = #{id}")
  end
end
