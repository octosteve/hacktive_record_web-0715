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

  def self.all
    sql = <<-SQL
      SELECT *
      FROM albums
    SQL

    results = DB.execute(sql)
    results.map {|row| self.new_from_row(row)}
  end

  def persisted?
    !!id
  end

  def save
    persisted? ? update : insert
  end

  private

  def insert
    sql = <<-SQL
      INSERT INTO albums (title, artist_id) VALUES (?,?)
    SQL

    DB.execute(sql, title, artist_id)
  end

  def update
    sql = <<-SQL
      UPDATE albums
      SET title=?, artist_id=?
      WHERE id=?
    SQL

    DB.execute(sql, title, artist_id, id)
  end
end
