class Artist < HacktiveRecord::Base
  attr_accessor :id, :name
  def self.new_from_row(row)
    a = new
    a.id = row["id"]
    a.name = row["name"]
    a
  end

  def attribute_methods
    [:name]
  end
end
