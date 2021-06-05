OPERATIONS_HASH_BST = Hash.new { |h, k| h[k] = {} }

def add_category(type, msg)
  OPERATIONS_HASH_BST[type] = { :msg => msg }
  type
end

module OperationCategory
  PRINT = add_category(1, "Print")
  MODIFY = add_category(2, "Modify")
  SEARCH = add_category(3, "Search")
end

def add_operation(type, msg, category)
  OPERATIONS_HASH_BST[category][type] = msg
  type
end

module Operations
  PRINT_PATHS = add_operation(1, "Print all root to leaf paths", OperationCategory::PRINT)
  SMALLEST = add_operation(2, "Print the smallest element", OperationCategory::PRINT)
  LARGEST = add_operation(3, "Print the largest element", OperationCategory::PRINT)
  PRE_ORDER = add_operation(4, "Print the pre order traversal", OperationCategory::PRINT)
  POST_ORDER = add_operation(5, "Print the post order traversal", OperationCategory::PRINT)
  IN_ORDER = add_operation(6, "Print the in order traversal", OperationCategory::PRINT)
  LEVEL_ORDER = add_operation(7, "Print the level order traversal", OperationCategory::PRINT)
  SEARCH = add_operation(1, "Search an element by value", OperationCategory::SEARCH)
  ADD_ELEMENTS = add_operation(1, "Add elements to the tree (comma seperated)", OperationCategory::MODIFY)
  DELETE = add_operation(2, "Delete an element by value", OperationCategory::MODIFY)
end
