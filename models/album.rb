class Album
  attr_accessor :id, :title, :artist_id
  def self.new_from_row(row)
    a = new
    a.id = row["id"]
    a.title = row["title"]
    a.artist_id = row["artist_id"]
    a
  end

  def self.find(id)
    sql = <<-SQL
      SELECT *
      FROM albums
      WHERE id=?
      LIMIT 1
    SQL
    results = DB.execute(sql, id)
    results.map {|row| self.new_from_row(row)}.first
  end
end
