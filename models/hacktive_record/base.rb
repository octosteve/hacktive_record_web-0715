module HacktiveRecord
  class Base
    def self.table_name
       self.name.downcase + "s"
    end
    def self.columns
       DB.table_info(table_name).map {|field| field["name"].to_sym}
    end

    def self.all
      sql = <<-SQL
        SELECT *
        FROM #{table_name}
      SQL

      results = DB.execute(sql)
      results.map {|row| self.new_from_row(row)}
    end

    def self.find(id)
      sql = <<-SQL
        SELECT *
        FROM #{table_name}
        WHERE id=?
        LIMIT 1
      SQL
      results = DB.execute(sql, id)
      results.map {|row| self.new_from_row(row)}.first
    end

    def persisted?
      !!id
    end

    def save
      persisted? ? update : insert
    end

    def placeholders
      ("?," * attribute_methods.count).chop
    end

    private

    def insert
      sql = <<-SQL
        INSERT INTO #{self.class.table_name}
        (#{attribute_methods.join(", ")})
        VALUES #{placeholders}
      SQL
      values_array = attribute_methods.map do |meth|
        self.send(meth)
      end

      DB.execute(sql, values_array)
    end
    def fields_for_set
      attribute_methods.map do |attr|
        "#{attr}=?"
      end.join(", ")
    end

    def update
      sql = <<-SQL
        UPDATE #{self.class.table_name}
        SET #{fields_for_set}
        WHERE id=?
      SQL
      values_array = attribute_methods.map do |meth|
        self.send(meth)
      end
      DB.execute(sql, *values_array, id)
    end
  end
end
