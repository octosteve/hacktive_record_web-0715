class Artist
  attr_accessor :id, :name
  def self.new_from_row(row)
    a = new
    a.id = row["id"]
    a.name = row["name"]
    a
  end

  def self.find(id)
    sql = <<-SQL
      SELECT *
      FROM artists
      WHERE id=?
      LIMIT 1
    SQL
    results = DB.execute(sql, id)
    results.map {|row| self.new_from_row(row)}.first
  end

  def self.all
    sql = <<-SQL
      SELECT *
      FROM artists
    SQL

    results = DB.execute(sql)
    results.map {|row| self.new_from_row(row)}
  end

  # def id=(new_id)
  #   raise "You cannot set id" if @id
  #   @id = new_id
  # end
  def persisted?
    !!id
  end

  def save
    persisted? ? update : insert
  end

  private

  def insert
    sql = <<-SQL
      INSERT INTO artists (name) VALUES (?)
    SQL

    DB.execute(sql, name)
  end

  def update
    sql = <<-SQL
      UPDATE artists
      SET name=?
      WHERE id=?
    SQL

    DB.execute(sql, name, id)
  end
end
