require_relative "./bst_driver.rb"
require_relative "./node.rb"

class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
    super value
    @left = nil
    @right = nil
  end
end

class BST
  def intitialize
    @root = nil
  end

  def insert(value)
    if @root == nil
      @root = TreeNode.new(value)
    else
      curr_node = @root
      prev_node = @root

      while curr_node != nil do
        prev_node = curr_node
        if curr_node.value >= value
          curr_node = curr_node.left
        else
          curr_node = curr_node.right
        end
      end

      if prev_node.value >= value
        prev_node.left = TreeNode.new(value)
      else
        prev_node.right = TreeNode.new(value)
      end
    end
  end

  def largest(root = @root)
    return nil if root.nil?

    curr_node = root
    while curr_node.right != nil
      curr_node = curr_node.right
    end
    #puts "#{curr_node.value} is largest"
    return curr_node.value
  end

  def smallest(root = @root)
    return if root.nil?
    curr_node = root
    while curr_node.left != nil
      curr_node = curr_node.left
    end
    #puts "#{curr_node.value} is smallest"
    return curr_node.value
  end

  def inorder()
    values = []
    inorder_rec(@root,values)
    return values
  end

 def inorder_rec(root,values)
  if root != nil
    inorder_rec(root.left)
    print "#{root.value} "
    values << root.value
    inorder_rec(root.right)
  end
 end
 def preorder
  values = []
  preorder_rec(@root, values)
  return values
 end

  def preorder_rec(root, values)
   if root != nil
     print "#{root.value} "
     values << root.value
     preorder_rec(root.left,values)
     preorder_rec(root.right,values)
   end
  end

  def postorder
    values = []
    postorder_rec(@root)
    return values
  end

  def postorder_rec(root)
    if root != nil
      postorder_rec(root.left)
      postorder_rec(root.right)
      print "#{root.value} "
      values << root.value
    end
  end

  def level_order()
    q = Queue.new
    q.push(@root)
    puts ""
    until q.empty?
      size = q.length

      size.times do
        curr_node = q.pop
        print curr_node.value, " "
        if curr_node.left != nil
          q.push(curr_node.left)
        end
        if curr_node.right != nil
          q.push(curr_node.right)
        end
      end
      puts ""
    end
  end

  def find(val)
    curr_node = @root

    while curr_node != nil
      if curr_node.value == val
        puts "#{val} is present"
        return
      elsif curr_node.value < val
        curr_node = curr_node.right
      else
        curr_node = curr_node.left
      end
    end
    puts "#{val} is not present"
  end

  def remove(val)
    @root = remove_rec(@root,val)
  end

  def remove_rec(root,val)
    return nil if root.nil?

    if root.value < val
      root.right = remove_rec(root.right,val)
    elsif root.value > val
      root.left = remove_rec(root.left,val)
    else
      if root.left == nil && root.right == nil
        root = nil
      elsif root.right == nil
        root = root.left
      elsif root.left == nil
        root = root.right
      else
        temp = largest(root.left)
        root.value = temp
        root.left = remove_rec(root.left,temp)
      end
    end
    return root
  end

  def all_path(root = @root, path = [])
    if root == nil
      return
    end
    path << root.value
    if root.left == nil && root.right == nil
      print_fun(path)
    end
    if root.left != nil
      path1 = path.clone
      all_path(root.left, path1)
    end
    if root.right != nil
      path1 = path.clone
      all_path(root.right, path1)
    end
  end

  def print_fun(path)
    path.each{|val| print val," "}
    puts ""
  end

  def load()
    print "Enter file name to load from: "
    name = gets.chomp
    #print name
    #begin
      file = File.open("./#{name}.txt")
      data = file.read
      file.close
      data = data.split(',')
      elements = []
      data.each{|val| elements << val.to_i} #convert into integer
      elements.each{|val| insert(val)}

  end

  def save()
    print "Name your file to save : "
    name = gets.chomp
    result = preorder()

    File.open("#{name}.txt", 'w') { |file|
        result.each do |value|
          file << value
          file << ','
        end
      }

    puts "Tree saved as #{name}.txt"
  end

end

def bst_print(bst, choice)
  case choice
  when 1
    puts "All paths are: "
    bst.all_path

  when 2
    val = bst.smallest
    if val == nil
      puts "Tree is empty"
    else
      puts "#{val} is smallest"
    end

  when 3
    val = bst.largest
    if val == nil
      puts "Tree is empty"
    else
      puts "#{val} is largest"
    end

  when 4
    puts "PREORDER"
    bst.preorder
    puts

  when 5
    puts "POSTORDER"
    bst.postorder
    puts

  when 6
    puts "INORDER"
    bst.inorder
    puts

  when 7
    puts "LEVELORDER"
    bst.level_order
    puts

  end
end

def bst_modify(bst, choice)
  case choice

  when 1
    puts "Enter elements to be inserted in binary search tree(comma separated)"
    temp = gets.chomp.split(',')
    elements = []
    temp.each{|val| elements << val.to_i} #convert into integer
    elements.each{|val| bst.insert(val)}

  when 2
    print "Element to be removed: "
    val = gets.chomp.to_i
    bst.remove(val)

  end
end

def bst_search(bst, choice)
  case choice

  when 1
    puts "Element to be found: "
    val = gets.chomp.to_i
    bst.find(val)

  end
end

def spec_menu(bst, values, prev_choice)

  values.each_with_index do |(key, val), index|
    if index != 0
      print key, '. ', val
      puts
    end
  end

  choice = gets.chomp.to_i
  #puts "#{prev_choice}"
  case prev_choice

  when 1
    bst_print(bst, choice)

  when 2
    bst_modify(bst, choice)

  when 3
    bst_search(bst, choice)

  end
end

def bst_choices(bst)

  OPERATIONS_HASH_BST.each do |key, val|
    val.each do |key1, val1|
      print key, '. ', val1
      puts
      break
    end
  end
  print "Enter the choice: "
  choice = gets.chomp.to_i
  puts

  OPERATIONS_HASH_BST.each do |key, val|
    if key.to_i == choice
      #puts "step 1"
      spec_menu(bst, val, choice)
      break
    end
  end
end

def main_bst
  bst = BST.new
  while true
    bst_choices(bst)
  end
end
