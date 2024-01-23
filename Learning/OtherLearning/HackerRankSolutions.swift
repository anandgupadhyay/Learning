//
//  HackerRankSolutions.swift
//  Learning
//
//  Created by Anand Upadhyay on 22/01/24.
//

import Foundation

/*
 Given a string of lowercase letters in the range ascii[a-z], determine the index of a character that can be removed to make the string a palindrome. There may be more than one solution, but any will do. If the word is already a palindrome or there is no solution, return -1. Otherwise, return the index of a character to remove.
 
func palindromeIndex(s: String) -> Int {
    let chars = Array(s)
    let length = s.count
    
    // Helper function to check if a string is a palindrome
    func isPalindrome(start: Int, end: Int) -> Bool {
        var i = start
        var j = end
        while i < j {
            if chars[i] != chars[j] {
                return false
            }
            i += 1
            j -= 1
        }
        return true
    }
    
    var i = 0
    var j = length - 1
    
    while i < j {
        if chars[i] != chars[j] {
            // Try removing either the character at index i or j to make it a palindrome
            if isPalindrome(start: i + 1, end: j) {
                return i
            } else if isPalindrome(start: i, end: j - 1) {
                return j
            } else {
                // If neither works, there is no solution
                return -1
            }
        }
        i += 1
        j -= 1
    }
    
    // The string is already a palindrome
    return -1
}

// Example usage:
let result = palindromeIndex(s: "abca")
print(result) // Output: 1
 */

