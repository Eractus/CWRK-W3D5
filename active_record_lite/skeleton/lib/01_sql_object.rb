require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @columns || @columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        cats
    SQL
    @columns.first.map { |el| el.to_sym }
  end

  def self.finalize!
    self.columns.each do |column|
      self.send(:define_method, column.to_sym) do
        self.attributes[column.to_sym]
      end
      self.send(:define_method, ("#{column}=").to_sym) do |val|
        self.attributes[column.to_sym] = val
      end
    end
  end

  def self.table_name=(table_name)
    # ...
  end

  def self.table_name
    self.to_s.split(/(?=[A-Z])/).join("_").downcase + "s"
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.keys.map!(&:to_sym)
    params.each do |attr_name, value|
      if self.class.columns.include?(attr_name)
        self.send("#{attr_name}=", value)
      else
        raise "unknown attribute '#{attr_name}'"
      end
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.attributes.values
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
