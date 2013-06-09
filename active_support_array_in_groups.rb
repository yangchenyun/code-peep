require 'rspec'

class Array
  def in_groups(number, fill_with = nil)
    division = size.div number
    modulo = size % number

    start = 0
    groups = []

    number.times do |index|
      length = division + (modulo > 0 && modulo > index ? 1 : 0)

      last_group = slice(start, length)
      last_group << fill_with if modulo > 0 &&
        length == division &&
        fill_with != false

      groups << last_group
      start += length
    end

    if block_given?
      groups.each { |group| yield(group) }
    else
      groups
    end
  end
end

describe Array do
  describe '#in_groups' do
    let(:array) { (1..7).to_a }
    it 'returns the correct array size' do
      1.upto(array.size + 1) do |number|
        array.in_groups(number).size.should == number
      end
    end

    it 'returns groups of empty arrays' do
      [].in_groups(3).should == [[], [], []]
    end

    it 'yields group one by one to groups' do
      groups = []

      array.in_groups(3) do |group|
        groups << group
      end

      groups.should == array.in_groups(3)
    end

    it 'splits perfect fit groups' do
      (1..9).to_a.in_groups(3).should == [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    end

    it 'add nil padding to non perfect fit groups' do
      array.in_groups(3).should == [[1, 2, 3], [4, 5, nil], [6, 7, nil]]
    end

    it 'add given padding to non perfect fit groups' do
      array.in_groups(3, 'foo').should == [[1, 2, 3], [4, 5, 'foo'], [6, 7, 'foo']]
    end

    it 'doesnt add padding if give the false fill_in' do
      (1..7).to_a.in_groups(3, false).should == [[1, 2, 3], [4, 5], [6, 7]]
    end
  end
end
