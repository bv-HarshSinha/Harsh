DS_HASH = Hash.new {}

def add_category(type, msg)
  DS_HASH[type] = msg
  type
end

module OperationCategory
  BST = add_category(1, "Binary Search Tree")
  LL = add_category(2, "Linked List")
end

print DS_HASH
