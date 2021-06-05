OPERATIONS_HASH_LL = Hash.new { |h, k| h[k] = {} }

def add_category(type, msg)
  OPERATIONS_HASH_LL[type] = { :msg => msg }
  type
end

module OperationCategory
  PRINT = add_category(1, "Print")
  MODIFY = add_category(2, "Modify")
  SEARCH = add_category(3, "Search")
end

def add_operation(type, msg, category)
  OPERATIONS_HASH_LL[category][type] = msg
  type
end

module Operations
  PRINT_LL = add_operation(1, "Print linked list", OperationCategory::PRINT)
  SEARCH = add_operation(1, "Search an element by value", OperationCategory::SEARCH)
  ADD_ELEMENTS = add_operation(1, "Add elements to the linked list (comma seperated)", OperationCategory::MODIFY)
  DELETE = add_operation(2, "Delete an element by value", OperationCategory::MODIFY)
end
