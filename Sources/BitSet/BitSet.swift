//
//  BitSet.swift
//  BitSet
//
//  Created by Bernardo Breder on 06/01/17.
//
//

import Foundation

public class BitSet {
    
    public typealias Word = UInt64
    
    internal let N = 64

    public internal(set) var count: Int
    
    public internal(set) var words: [Word]
    
    internal let allOnes = ~Word()
    
    public init(count: Int) {
        self.count = count
        let n = (count + (N-1)) / N
        self.words = [Word](repeating: 0, count: n)
    }
    
    public init(count: Int, words: [Word]) {
        self.count = count
        self.words = words
    }
    
    public subscript(i: Int) -> Bool {
        get { return isSet(i) }
        set { if newValue { set(i) } else { clear(i) } }
    }
    
    @discardableResult
    public func set(_ i: Int) -> Self {
        let (j, m) = indexOf(i)
        words[j] |= m
        return self
    }
    
    @discardableResult
    public func setAll() -> Self {
        for i in 0..<words.count {
            words[i] = allOnes
        }
        clearUnusedBits()
        return self
    }
    
    @discardableResult
    public func clear(_ i: Int) -> Self {
        let (j, m) = indexOf(i)
        words[j] &= ~m
        return self
    }
    
    @discardableResult
    public func clearAll() -> Self {
        for i in 0..<words.count {
            words[i] = 0
        }
        return self
    }
    
    public func flip(_ i: Int) -> Bool {
        let (j, m) = indexOf(i)
        words[j] ^= m
        return (words[j] & m) != 0
    }
    
    public func isSet(_ i: Int) -> Bool {
        let (j, m) = indexOf(i)
        return (words[j] & m) != 0
    }
    
    public var cardinality: Int {
        var count = 0
        for var x in words {
            while x != 0 {
                let y = x & ~(x - 1)
                x = x ^ y
                count += 1
            }
        }
        return count
    }
    
    public func all1() -> Bool {
        for i in 0..<words.count - 1 {
            if words[i] != allOnes { return false }
        }
        return words[words.count - 1] == lastWordMask()
    }
    
    public func any1() -> Bool {
        for x in words {
            if x != 0 { return true }
        }
        return false
    }
    
    public func all0() -> Bool {
        for x in words {
            if x != 0 { return false }
        }
        return true
    }
    
    internal func indexOf(_ i: Int) -> (Int, Word) {
        let o = i / N
        let m = Word(i - o * N)
        return (o, 1 << m)
    }
    
    internal func lastWordMask() -> Word {
        let diff = words.count * N - count
        if diff > 0 {
            let mask = 1 << Word(63 - diff)
            return mask | (mask - 1)
        } else {
            return allOnes
        }
    }
    
    internal func clearUnusedBits() {
        words[words.count - 1] &= lastWordMask()
    }

}

extension BitSet {
    
    public static func & (lhs: BitSet, rhs: BitSet) -> BitSet {
        let m = max(lhs.count, rhs.count)
        let out = BitSet(count: m)
        let n = min(lhs.words.count, rhs.words.count)
        for i in 0 ..< n {
            out.words[i] = lhs.words[i] & rhs.words[i]
        }
        return out
    }
    
    public static func | (lhs: BitSet, rhs: BitSet) -> BitSet {
        let out = copyLargest(lhs, rhs)
        let n = min(lhs.words.count, rhs.words.count)
        for i in 0 ..< n {
            out.words[i] = lhs.words[i] | rhs.words[i]
        }
        return out
    }
    
    public static func ^ (lhs: BitSet, rhs: BitSet) -> BitSet {
        let out = copyLargest(lhs, rhs)
        let n = min(lhs.words.count, rhs.words.count)
        for i in 0 ..< n {
            out.words[i] = lhs.words[i] ^ rhs.words[i]
        }
        return out
    }
    
    prefix public static func ~ (rhs: BitSet) -> BitSet {
        let out = BitSet(count: rhs.count)
        for i in 0..<rhs.words.count {
            out.words[i] = ~rhs.words[i]
        }
        out.clearUnusedBits()
        return out
    }
    
    private static func copyLargest(_ lhs: BitSet, _ rhs: BitSet) -> BitSet {
        return (lhs.words.count > rhs.words.count) ? lhs : rhs
    }
    
}

extension BitSet: Equatable {
    
    public static func == (lhs: BitSet, rhs: BitSet) -> Bool {
        return lhs.words == rhs.words
    }
    
}

extension BitSet: Hashable {
    
    public var hashValue: Int {
        var h = Word(1234)
        for i in stride(from: words.count, to: 0, by: -1) {
            h ^= words[i - 1] &* Word(i)
        }
        return Int((h >> 32) ^ h)
    }
    
}

extension BitSet: CustomStringConvertible {

    public var description: String {
        var s = ""
        for x in words {
            s += BitSet.bitsToString(x) + "\n"
        }
        return s.substring(to: s.index(s.startIndex, offsetBy: count))
    }
    
    private static func bitsToString(_ value: UInt64) -> String {
        var s = ""
        var n = value
        for _ in 1...64 {
            s += ((n & 1 == 1) ? "1" : "0")
            n >>= 1
        }
        return s
    }

}
