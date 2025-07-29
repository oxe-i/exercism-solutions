=begin
Write your code for the 'Binary Search Tree' exercise in this file. Make the tests in
`binary_search_tree_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/binary-search-tree` directory.
=end

class Bst
  def initialize(value)
    @data = value
  end

  def data
    @data
  end

  def insert(value)
    if not @left and value <= @data
      @left = Bst.new(value)
    elsif not @right and value > @data
      @right = Bst.new(value)
    elsif @left and value <= @data
      @left.insert(value)
    elsif @right and value > @data
      @right.insert(value)
    end
  end

  def left
    @left
  end

  def right
    @right
  end

  def each(&block)   
    @all_data = []

    def inorder(node)
      if node
        inorder(node.left)
        @all_data.push(node.data)
        inorder(node.right)
      end
    end

    inorder(self)
    @all_data.each(&block)
  end

end
    
