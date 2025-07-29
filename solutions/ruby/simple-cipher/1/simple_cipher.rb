=begin
Write your code for the 'Simple Cipher' exercise in this file. Make the tests in
`simple_cipher_test.rb` pass.

To get started with TDD, see the `README.md` file in your
`ruby/simple-cipher` directory.
=end

class Cipher
  def random
    charset = ('a'..'z').to_a
    Array.new(100) {charset.sample}.join
  end

  def char_diff(letter)
    letter.ord - 'a'.ord
  end

  def initialize(key = self.random)
    raise ArgumentError if key.empty? or not (/\A[a-z]+\z/).match(key)
    @key = key
    @offset = key.split("").map {|letter| char_diff(letter)}
  end

  def key
    @key
  end

  def encode(plaintext)
    index = -1
    plaintext.split("").map {|letter|
      index += 1
      ('a'.ord + (char_diff(letter) + @offset[index]).modulo(26)).chr
    }.join
  end

  def decode(ciphertext)
    index = -1
    ciphertext.split("").map {|letter|
      index += 1
      ('a'.ord + (char_diff(letter) - @offset[index]).modulo(26)).chr
    }.join
  end
end