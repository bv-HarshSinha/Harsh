require_relative "./node.rb"
require_relative "./ll_driver.rb"
class LinkedNode < Node

  attr_accessor :left, :right
  def initialize(value)
    super value
    @left = nil
  end
end

class LinkedList

  def initialize()
    @root = nil
  end

  def insert(val)
    if @root.nil?
      @root = LinkedNode.new(val)
      return
    end
    curr_node = @root
    while curr_node.left != nil
      curr_node = curr_node.left
    end
    curr_node.left = LinkedNode.new(val)
  end

  def find(val)
    curr_node = @root
    while curr_node != nil
      if curr_node.left == val
        return 1
      end
      curr_node = curr_node.left
    end
    return 0
  end

  def remove(val)
    return if @root.nil?

    if @root.value == val
      @root = @root.left
      return
    end

    curr_node = @root
    while curr_node.left != nil && curr_node.left.value != val
      curr_node = curr_node.left
    end

    if curr_node.left != nil
      curr_node.left = curr_node.left.left
    end
  end

  def reverse
    curr_node = @root
    while curr_node != nil
      temp = ListNode(curr_node.value)
      temp.left = @root
      @root = temp
      curr_node = curr_node.left
    end
  end

  def print_ll
    curr_node = @root
    while curr_node != nil
      print curr_node.value, " "
      curr_node = curr_node.left
    end
  end

end

def ll_print(ll, choice)
  case choice
  when 1
    ll.print_ll
  end
end

def ll_modify(ll, choice)
  case choice
  when 1
    puts "Enter elements to be inserted in linked list(comma separated)"
    temp = gets.chomp.split(',')
    elements = []
    temp.each{|val| elements << val.to_i} #convert into integer
    elements.each{|val| ll.insert(val)}

  when 2
    print "Element to be removed: "
    val = gets.chomp.to_i
    ll.remove(val)
  end
end

def ll_search(ll, choice)
  case choice
  when 1
    puts "Element to be found: "
    val = gets.chomp.to_i
    ll.find(val)
  end
end

def spec_menu(ll, values, prev_choice)

  values.each_with_index do |(key, val), index|
    if index != 0
      print key, '. ', val
      puts
    end
  end

  choice = gets.chomp.to_i
  case prev_choice

  when 1
    ll_print(ll, choice)

  when 2
    ll_modify(ll, choice)

  when 3
    ll_search(ll, choice)

  end
end

def ll_choices(ll)

  OPERATIONS_HASH_LL.each do |key, val|
    val.each do |key1, val1|
      print key, '. ', val1
      puts
      break
    end
  end

  print "Enter the choice: "
  choice = gets.chomp.to_i
  puts

  OPERATIONS_HASH_LL.each do |key, val|
    if key.to_i == choice
      #puts "step 1"
      spec_menu(ll, val, choice)
      break
    end
  end
end

def main_ll
  ll = LinkedList.new

  while true
    ll_choices(ll)
  end
end
