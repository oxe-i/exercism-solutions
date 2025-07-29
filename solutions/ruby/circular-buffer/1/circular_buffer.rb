=begin
Write your code for the 'Circular Buffer' exercise in this file. Make the tests in
`circular_buffer_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/circular-buffer` directory.
=end

class CircularBuffer
  class BufferEmptyException < Exception 
    end
  class BufferFullException < Exception 
    end
  
  def initialize(size)
    @buffer = Array.new
    @size = size
    @num_of_elements = 0
    @oldest_element_index = 0
    @newest_element_index = 0
  end

  def update_old_index
    if @oldest_element_index < @size - 1
      @oldest_element_index += 1
    else
      @oldest_element_index = 0
    end
  end

  def update_new_index
    if @newest_element_index < @size - 1
      @newest_element_index += 1
    else
      @newest_element_index = 0
    end
  end
    
  def read
    raise BufferEmptyException if @num_of_elements == 0
    read_value = @buffer.at(@oldest_element_index)
    self.update_old_index
    @num_of_elements -= 1
    return read_value
  end

  def write(value)
    raise BufferFullException if @num_of_elements == @size
    @buffer[@newest_element_index] = value
    update_new_index
    @num_of_elements += 1
  end

  def clear
    @buffer.clear
    @num_of_elements = 0
    @oldest_element_index = 0
    @newest_element_index = 0
  end

  def write!(value)
    if @num_of_elements == @size
      @buffer[@oldest_element_index] = value
      update_old_index
    elsif 
      write(value)
    end
  end
end