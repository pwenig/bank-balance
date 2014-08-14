class CheckingStatement

  def initialize(statement)
    @statement = statement
  end


  def read_lines
    rows = []
    statement_array = File.open(@statement).readlines
    statement_array.delete_at(0)

    statement_array.each do |line|
      rows << line.gsub("\n", "")
    end
    rows
  end

end