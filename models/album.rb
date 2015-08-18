class Album < HacktiveRecord::Base
  attr_accessor :id, :title, :artist_id
  def self.new_from_row(row)
    a = new
    a.id = row["id"]
    a.title = row["title"]
    a.artist_id = row["artist_id"]
    a
  end

  def attribute_methods
    [:title, :artist_id]
  end
end
