require "csv"

class CheckingStatement

  attr_accessor :file_array

  def initialize(file)
    @file = file
    @file_array = []
  end

  def read_lines
    #read the file
    statement_array = File.open(@file).readlines
    statement_array.delete_at(0)

    @file_array = statement_array.collect do |row|
      row.gsub("\n", "")
    end

    # rows = []
    # file.each do |row|
    #   rows << row.gsub("\n", "")
    # end
    # rows

  end

  def checking_totals
    self.read_lines
    #get the array of lines from read_files
    #parse the array and add the last elements of the array(total) together
    total = 0
    file_array.each do |row|
      row.split(',').last.gsub("$","")
      total += row.split(',').last.gsub('$', "").to_i
    end
    total
    # each through the loop
    # split each row into an array
    # grab the last element
    # add that element to the total
    # return the total
  end

  def deposit_total
    self.read_lines
    selected_rows = @file_array.select do |row|
     row.split(',')[1].include?("Deposit")
    end

    total = 0
    selected_rows.each do |row|
      total += row.split(',').last.gsub('$','').split('"').last.to_i
    end
    total

  end

end