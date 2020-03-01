class Array 
	def quicksort
		return [] if empty?

		pivot = delete_at(rand(size))
		left, right = partition(&pivot.method(:>))

		return *left.quicksort, pivot, *right.quicksort

	end

end

arr = [5,8,3,6,8,9,0,3,1,4]

p arr.quicksort