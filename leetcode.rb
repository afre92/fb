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
    # check if there is more than one letter 
    # e.i for 'abca' s[low+1..high] = c which c.reverse == c 
    # e.i for 'abxc' s[low+1..high] = xc which 'xc'.reverse != 'xc'
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
    #ruby way
    def intersection(nums1, nums2)
        nums1 & nums2
    end

    #other

    def intersection(nums1, nums2)
    result = []
    return result if nums1.empty? || nums2.empty?
    
    hash = {}
    nums1.each do |num|
        hash[num] = 1
    end
    
    nums2.each do |num1|
        result << num1 if hash[num1] == 1
        hash[num1] = 2
    end
    p result
    
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


# minimun window substring

# @param {String} s
# @param {String} t
# @return {String}
def min_window(s, t)
    current_set = {}
    t.each_char do |c|
        current_set[c] ||= 0
        current_set[c] -= 1
    end
    
    # current_ser = {"A"=>-1, "B"=>-1, "C"=>-1}

    valid_count = current_set.keys.length * -1
    # valid_count = -3
    left = 0
    min_window = ""
    s.each_char.with_index do |c, right_index|
        if current_set[c]
            # if current s value exists in current_set add one to make it less possitive
            current_set[c] += 1
            valid_count += 1 if current_set[c] == 0
        end
        if valid_count >= 0
            while valid_count >= 0
                if current_set[s[left]]
                    current_set[s[left]] -= 1
                    valid_count -= 1 if current_set[s[left]] == -1
                end
                left += 1
            end
            if min_window.length == 0 || min_window.length >= right_index - left + 2
                min_window = s[left-1..right_index]
            end
        end
    end
    min_window
end


# sort colors

# @param {Integer[]} nums
# @return {Void} Do not return anything, modify nums in-place instead.
def sort_colors(nums)
    return if nums.length == 0 || nums.length ==1
    
    # start will move in whenever it encounters a 0
    # start will always sit wherever the next 0 should go
    start = 0
    # end will also move in whenever it encounters a 2
    # end will always sit wherever the next 2 should go
    end_i = nums.length-1
    index = 0

    # while we are not at the last index
    # and we are in the right bounderies
    while index <= end_i && start < end_i do
        if nums[index] == 0
            #swap
            nums[index] = nums[start]
            nums[start] = 0
            start += 1
            index += 1
        elsif (nums[index] == 2)
            #swap
            nums[index] = nums[end_i]
            nums[end_i] = 2
            end_i -= 1
        else
            index += 1
        end
    end
end

# 3sum

# @param {Integer[]} nums
# @return {Integer[][]}
def three_sum(nums)
    # sort is needed bc of the two pointers
    nums.sort!
    output_arr = []
    
    # -2 bc we are finding two items AFTER, and we dont wanna run out of bounce
    (0..nums.length-2).each do |i|
        # takes care of the duplicates
        if i == 0 || (i > 0 && nums[i] != nums[i-1])
            # index item to the right of current item
            low = i+1
            # index of last item
            high = nums.length-1
            # 0-(-1) = 1
            sum = 0-nums[i]
            
            while low < high
                # if true we just found our sum
                if nums[low] + nums[high] == sum
                    output_arr.push([nums[i], nums[low], nums[high]])
                    
                    # 2 < 5 && -1 == 0
                    while low < high && nums[low] == nums[low+1]
                        #move right boundry to the right
                        low += 1
                    end
                    
                    # 2 < 5 && 2 == - 1
                    while low < high && nums[high] == nums[high-1]
                        # move the left boundry to the left
                        high -= 1
                    end
                    
                    low += 1
                    high -= 1
                    # 0 + 1 > 1
                elsif nums[low] + nums[high] > sum
                    high -= 1
                else
                    low += 1
                end
            end
        end
            
       
    end
     return output_arr
end

# Binary tree level order traversal

def level_order(root)
  return [] if root.nil? #"If there is no root return an empty array"
  queue = [ root ] #" Our Queue starts with the root inside of it"
  level = [] #"All nodes per level go here"
  order = [] #"Our return value for all levels"
  children = [] # All the nodes children go here"

  while queue.length > 0  #"Until our queue is empty"
    node = queue.shift #"We must Shift(FIFO), Our current Node, and how we escape out of the loop"
    level.push(node.val) #"Collect the node's value, one by one"

    children.push(node.left) if !node.left.nil?  #"Notice we push it into the children Array if there is a left child"
    children.push(node.right) if !node.right.nil? #"Same for the right child"

        if queue.empty? #"Important. Once the queue is empty we know the level is complete"
            order.push(level) #"Push our level into our Order Array and reset its value below"
            level = [] 

            if children.length > 0 #"When the queue is empty(above) and IF there are children"
                queue.push(*children) #"We push the children into our Queue...we are ready for the next level, also notice we are using the spread operator to push the children in as arguements and not an array"
                children = [] #" Reset the children value.
            end
        end
    end

    return order #"Once we are out of the loop we have collected all our levels"

end

# valid Parentheses

def is_valid(s)
    return true if s.empty?
    
    stack = []
    s.each_char do |c|
        case c
        when '(', '{', '['
            stack.push(c)
        when ')'
            return false if stack.pop() != '('
        when '}'
            return false if stack.pop() != '{'
        when ']'
            return false if stack.pop() != '['
        end
    end
    return stack.empty?
end


# continuous subarray sum


# We iterate through the input array exactly once, keeping track of the running sum mod k of the elements in the process. If we find that a running sum value at index j has been previously seen before in some earlier index i in the array, then we know that the sub-array (i,j] contains a desired sum.
def check_subarray_sum(nums, k)
    map = {}
    map[0] = -1
    running_sum = 0
    nums.each_with_index do |num, index|
        running_sum += nums[index]
        
        if k != 0
            # why ?
           
            running_sum = running_sum % k
            
        end
         print map, '--'
#          print running_sum, '--'
        prev = map[running_sum]
        if prev != nil
            return true if index - prev > 1
        else
            map[running_sum] = index
        end
    end
    return false
end

# Subarray sum equals K

def subarray_sum(nums, k)
    subarray_count = 0
    map = {0 => 1}
    sum = 0
    
    nums.each_with_index do |n, idx|
        
        new_sum = sum += n
        # newsum = 1
        
        # if key exists
        if map[new_sum - k]
            
            subarray_count += map[new_sum - k]
        end
        
        map[new_sum].nil? ? map[new_sum] = 1 : map[new_sum] += 1
           
        sum = new_sum
    end
    
    return subarray_count
end


# move Zeroes

def move_zeroes(nums)
    i = 0 
    j = nums.length
    while j > 0
        if nums[i] == 0
            nums.delete_at(i)
            nums.push(0)
        else
            i += 1
        end
        j -= 1
    end
end

# Find kth largest element in an array

#optimal solution 92% faster
def find_kth_largest(nums, k)
  k <= nums.size ? (p nums.sort!.reverse[k-1] ) : (p -1)
end


# applying binary search
# he idea is to search for the answer, and check whether the given answer is at Kth maximum position.

# Given the range of all possible value, we can narrow down the range of final results by using binary search. For example, the range of all possible value is 0 .. 100,

# we first try whether mid-value (e.g. 50) is the Kth maximum position.
# To verify, we scan the array and count how many elements are greater than or equal to 50.
# if the count > K, then the real answer should be greater than mid-value (e.g. 50), we search answer in 51 ... 100; otherwise, the real answer should be less than mid-value, we search answer in 0..50
def find_kth_largest(nums, k)
    min, max = nums[0], nums[0]
    nums.each {|x| 
        min = [min, x].min
        max = [max, x].max
    }
    while min <= max 
        mid = (min + max) / 2
        count = 0;
        nums.each{|x| count += 1 if x >= mid}
        if count >= k
            min = mid + 1
        else
            max = mid - 1
        end
    end
    return max
end



# Product of array except self F:HIGH

    def product_except_self(nums)
        ans = [1]
        # Calculate the left side values
        (1..(nums.length - 1)).each do |i|
           ans[i] = ans[i-1] * nums[i-1] 
        end
        
        r = 1
       # Calculate right side values
        ((nums.length-1).downto(0)).each do |i|
            ans[i] *= r
            r *= nums[i]
        end
        ans
    end

    # java

    public class Solution {
        public int[] productExceptSelf(int[] nums) {
            int n = nums.length;
            int[] res = new int[n];
            // Calculate lefts and store in res.
            int left = 1;
            for (int i = 0; i < n; i++) {
                if (i > 0)
                    left = left * nums[i - 1];
                res[i] = left;
            }
            // Calculate rights and the product from the end of the array.
            int right = 1;
            for (int i = n - 1; i >= 0; i--) {
                if (i < n - 1)
                    right = right * nums[i + 1];
                res[i] *= right;
            }
            return res;
        }
    }


    #     i = num1.length - 1
#     j = num2.length - 1
#     sol = ''
#     carry = 0
#     while i >= 0 || j >= 0 || carry > 0
#         sum = carry
#         if i >= 0
#             # convert string to int using ordinal number
#             sum += num1[i].ord - '0'.ord
#             i -= 1
#         end
#         if j >= 0
#             # convert string to int using ordinal number
#             sum += num2[j].ord - '0'.ord
#             j -= 1
#         end
#         # get carry
#         carry = sum/10
#         # reminder , second digit  left after carry
#         sol = String(sum%10) + sol
#     end
    
#     sol


# Merge sorted Array

def merge(nums1, m, nums2, n)
    # there is a relation between the n and m
    # print nums1,'-1'
    # print nums2, '-2'
    while m > 0 and n > 0

        # 1. 3 >= 6
        # 2. 3 >= 5
        # 3. 3 >= 2
        print nums1
        if nums1[m-1] >= nums2[n-1]
            # 3. 0 = 3
            nums1[m+n-1] = nums1[m-1]
           
            m -= 1
        else
            # 1.replace last 0 with 6
            # 2.replace second-to-last 0 with 5
            nums1[m+n-1] = nums2[n-1]
            n -= 1
        end
    end
    if n > 0
        nums1[0...n] = nums2[0...n]
    end
end
