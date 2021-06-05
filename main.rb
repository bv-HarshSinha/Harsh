require_relative "./ds.rb"
require_relative "./bst.rb"
require_relative "./ll.rb"

DS_HASH.each do |key, val|
  print key, '. ', val
  puts
end

choice = gets.chomp.to_i

case choice
when 1
  main_bst
when 2
  main_ll
end
