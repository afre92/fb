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

