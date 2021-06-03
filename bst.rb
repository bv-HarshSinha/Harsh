class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
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

  def inorder
   return inorder_rec(@root)
  end

 def inorder_rec(root)
  if root != nil
    inorder_rec(root.left)
    print "#{root.value} "
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
   return postorder_rec(@root)
  end

  def postorder_rec(root)
    if root != nil
      postorder_rec(root.left)
      postorder_rec(root.right)
      print "#{root.value} "
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


def choices
  puts "
Select a number

1. Add elements into the tree(multiple elements comma separated)
2. Print the largest element
3. Print the smallest element
4. Print Inorder, postorder, level order, and preorder traversal
5. Search an element
6. Remove an element
7. Print all the paths i.e starting from root to the leaf
8. load BST from file.
9. Save Tree
10. Quit
    "
end

def choice_selector(bst, choice)
  case choice

  when 1
    puts "Elements(can be multiple elements but with comma separated)"
    temp = gets.chomp.split(',')
    elements = []
    temp.each{|val| elements << val.to_i} #convert into integer
    elements.each{|val| bst.insert(val)}

  when 2
    val = bst.largest
    if val == nil
      puts "Tree is empty"
    else
      puts "#{val} is largest"
    end

  when 3
    val = bst.smallest
    if val == nil
      puts "Tree is empty"
    else
      puts "#{val} is smallest"
    end

  when 4
    puts "Inorder"
    bst.inorder
    puts "\nPreorder"
    bst.preorder
    puts "\nPostorder"
    bst.postorder
    puts "\nLevelorder"
    bst.level_order

  when 5
    puts "Element to be found: "
    val = gets.chomp.to_i
    bst.find(val)

  when 6
    print "Element to be removed: "
    val = gets.chomp.to_i
    bst.remove(val)

  when 7
    puts "All paths are: "
    bst.all_path

  when 8
    bst.load

  when 9
    bst.save
  end
end


bst = BST.new

while true
  choices
  choice = gets.chomp.to_i
  if choice == 10
    break
  end
  choice_selector(bst,choice)
end
