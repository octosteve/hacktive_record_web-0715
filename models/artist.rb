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
end
