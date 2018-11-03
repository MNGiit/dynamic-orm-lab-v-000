require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  
  def self.table_name #method returns a name for table
    self.to_s.downcase.pluralize #turns Class name into a string, downcase, and pluralize it
  end 
  
  def self.column_names #returns an array of SQL column names
    DB[:conn].results_as_hash = true #.results_as_hash is part of a ruby gem
    #helps to get return values in hash instead of an array
 
    sql = "PRAGMA table_info('#{table_name}')" #SQL query for table names
 
    table_info = DB[:conn].execute(sql)
    column_names = []
 
    table_info.each do |column|
      column_names << column["name"] #each hash has a name key that points to a value of the column name
    end
    column_names.compact #.compact gets rid of any nil values
  end
  
  def table_name_for_insert
    self.class.table_name
  end
  
end