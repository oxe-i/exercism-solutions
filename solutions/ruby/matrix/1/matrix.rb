=begin
Write your code for the 'Matrix' exercise in this file. Make the tests in
`matrix_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/matrix` directory.
=end

class Matrix
  def initialize(string)
    @matrix = string.split("\n").map! {
      |row| row.to_s.split(" ").map! {
        |number| number.to_i
      }}
  end

  def row(index)
    @matrix.fetch(index - 1)
  end

  def column(index)
    @matrix.transpose.fetch(index - 1)
  end
end
