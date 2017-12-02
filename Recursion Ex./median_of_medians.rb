def find_median(arr, index_to_find = arr.length/2)
  left, right = arr[1..-1].partition{ |int| int <= arr[0] }
  partitioned_index = left.length
  return arr[0] if partitioned_index == index_to_find
  if left.length > right.length
    find_median(left, index_to_find)
  else
    find_median(right, index_to_find - (left.length + 1))
  end
end
