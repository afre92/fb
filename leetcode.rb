# Merge interval optimal solution

def merge(intervals)
    merged = []
    # sorting of array 
    intervals.sort! { |a,b| a[0] <=> b[0] }
    
    intervals.each do |interval|
        # if merged is empty of if there is no overlap
        if merged.empty? || merged.last[1] < interval[0]
            merged << interval
        else
        # change last last of merged if current interval > than last last of merged arr
            merged.last[1] = interval.last if interval.last > merged.last[1]
        end
    end
    return merged
end



# Valid Palindrome II

def valid_palindrome(s)
    return true if palindrome?(s)

    low = 0
    high = s.length - 1

    while s[low] == s[high] do 
        low += 1
        high -= 1
    end

    palindrome?(s[low+1..high]) || palindrome?(s[low..high -1])

end


def palindrome?(s)
    s == s.reverse
end


# Longest common subsequence

def longest_common_subsequence(text1, text2)
  memo = Array.new(text1.length) { Array.new(text2.length) }
  return helper(text1, text2, 0, 0, memo)
end

def helper(text1, text2, p1, p2, memo)
  return 0 if (p1 >= text1.length) || (p2 >= text2.length)

  return memo[p1][p2] if memo[p1][p2]

  if text1[p1] == text2[p2]
    memo[p1][p2] = 1 + helper(text1, text2, p1 + 1, p2 + 1, memo)
  else
    memo[p1][p2] = [helper(text1, text2, p1 + 1, p2, memo), helper(text1, text2, p1, p2 + 1, memo)].max
  end
end


# intersaction of tow arrays

def intersection(nums1, nums2)
    nums1 & nums2
end

# find first bad version
 #binary search
    def first_bad_version(n)
      left = 1
      right = n 
      while left < right 
        mid = (left +  (right - left) / 2) 
        if is_bad_version(mid) 
          right = mid
        else
          left = mid + 1
        end
      end
      left
    end 

    # or
    def first_bad_version(n)
        (1..n).bsearch { |i| is_bad_version(i) }
    end

#Binary tree right side view

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @return {Integer[]}
def right_side_view(root)
    sol = []
    if root.nil?
        return sol
    end
    # make queue equals to my root
    queue = [root]
    while !queue.empty?
        num_items_at_level = queue.length
        # loop by the length of queue
        num_items_at_level.times do |i|
            # pull the first item from the queue and make it current
            cur = queue.shift
            # add left leaf from current tree to queue if there is a left leaf
            queue.push(cur.left) if cur.left
            # add right leaf from current tree to queue if there is a right leaf
            queue.push(cur.right) if cur.right
            # if there are no more item at this level
            # how do we know where are taking the right side into the solution array ?
            if i == num_items_at_level - 1
                sol.push(cur.val)
            end
        end
    end
    
    return sol
end


# Verifying an alien dictionary

# @param {String[]} words
# @param {String} order
# @return {Boolean}
def is_alien_sorted(words, order)
    # gets indexes of each word in words array to loop
    (0...words.length - 1).each do |i|
        # first letter of first word
        a = words[i][0]
        # first letter of second word
        b = words[i + 1][0]
        puts b,'--'
        j = 1
        # if both first words are the same then keep looping through the word until find different
        while a == b
            a = words[i][j]
            b = words[i + 1][j]
            j += 1
        end
        #
        return false if b.nil?
        # return false if a comes before b 
        # if a come before b means the words are not sorted based on the alien dictionary 
        return false if order.index(a) > order.index(b)
    end
    
    true
end

# Next greater Element I

def next_greater_element(nums1, nums2)
  stack = []
    # create new hash where default is -1 when key is not found
  next_greater_ele = Hash.new(-1)
  result = []

# create hash with nums2 as keys and their value is the next grater element of the same array
  nums2.each { |n|
    #while stask and stack.last is smaller than current item
    while( stack.any? && stack.last < n )
        # add last item in stack as key and the next greater item as value on the hash
      next_greater_ele[stack.pop] = n
    end
    stack.push(n)
  }
  nums1.each { |n|
    result << next_greater_ele[n]
  }
  result
end

# permutation in string


def check_inclusion(s1, s2)
    #create hashes with an array as key and 0 as value ?
    map1 = Hash.new{|h,k| h[k] = 0 }
    map2 = Hash.new{|h,k| h[k] = 0 }
    # k is the length of the s1 string
    k = s1.size
    # edit hash to have each letter of string as key and number of times it appears as value
    s1.chars.each do |ch|
        map1[ch] += 1
    end
    
    #make sliding window
    #{"e"=>1, "i"=>1}
    (0...k).each do |i|
        map2[s2[i]] += 1
    end
    
    return true if map1 == map2
    
    #update window
    (k...s2.size).each do |i|
        map2[s2[i]] += 1
        map2[s2[i-k]] -= 1
        #{"e"=>0, "i"=>1, "d"=>1}--{"i"=>0, "d"=>1, "b"=>1}--{"d"=>0, "b"=>1, "a"=>1}--
        map2.delete(s2[i-k]) if map2[s2[i-k]] == 0
        return true if map1 == map2
    end
    return false
end

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer}
def search(nums, target)
    if (nums == nil || nums.length == 0)  
        return -1 
    end
    
    left = 0 
    right = nums.length - 1
    
    # goal to have these bounderies meet the the index of the smallest element of the array
    while (left< right) do 
        midpoint = left + (right -left)/2
        # if the elemnt on the mid point is greater than the element all the way to the right() which is how it should be on a sorted array
        if (nums[midpoint] > nums[right]) 
            # move left boundry to minpoint + 1 index, moving the search to the right side of array
            left = midpoint+1
        else
            # move right boundy to minpoint index, moving the search to the left side of the array
            right = midpoint
        end
    end
    
    start = left
    left = 0 
    right = nums.length - 1
    
    #if target is greater or equal our smallest number(start on sorted array)
    # and target is smaller or greare than right limit
    if target >= nums[start] && target <= nums[right] 
        left = start
    else
        right = start
    end
    # regular binary search
    while left <= right do
        midpoint  = left + (right - left)/2
        if nums[midpoint] == target
            return midpoint
        elsif nums[midpoint] < target
            left = midpoint + 1
        else
            right = midpoint - 1
        end
        
    
    end
    
    return -1
    
end
