require 'byebug'

#ls(arr) = greatest i ls(arr[0...-1]) wherein arr[-1] > arr[i]

def longest_subsequence(arr)
  ongoing_subsequence = [1]
  (1...arr.length).each do |i|
    (0...ongoing_subsequence.length).each do |j|
      if arr[i] > arr[j]
        next_subsequence = ongoing_subsequence[j] + 1
        if ongoing_subsequence[i].nil? || next_subsequence > ongoing_subsequence[i]
          ongoing_subsequence[i] = next_subsequence
        end
      end

      ongoing_subsequence[i] = 1 if ongoing_subsequence[i].nil?
    end
  end

  ongoing_subsequence[-1]
end
