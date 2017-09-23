//
//  BitSetWriter.swift
//  BitSet
//
//  Created by Bernardo Breder on 08/01/17.
//
//

import Foundation

public class BitSetWriter {
    
    typealias Word = UInt64
    
    let N = 64
    
    var words: [Word] = []
    
    var word: Word = 0
    
    var index = 0
    
    public init() {
    }
    
    @discardableResult
    public func set() -> Self {
        if index == 64 {
            words.append(word)
            index = 0
            word = 0
        }
        word |= 1 << Word(index)
        index += 1
        return self
    }
    
    @discardableResult
    public func set(bool: Bool) -> Self {
        if bool { return set() }
        else { return unset() }
    }
    
    @discardableResult
    public func set(bitSet: BitSet) -> Self {
        var word = 0, item = 0, index = 0
        while index < bitSet.count {
            if item == N {
                item = 0
                word += 1
            }
            if bitSet.words[word] & (1 << Word(item)) != 0 { set() } else { unset() }
            item += 1
            index += 1
        }
        return self
    }
    
    @discardableResult
    public func unset() -> Self {
        index += 1
        return self
    }
    
    public func bitSet() -> BitSet {
        if index != 0 {
            words.append(word)
        }
        let count = (words.count - 1) * N + index
        let bitSet = BitSet(count: count, words: words)
        index = 0
        words.removeAll()
        word = 0
        return bitSet
    }
    
    internal func indexOf(_ i: Int) -> Word {
        let o = i / N
        let m = Word(i - o * N)
        return 1 << m
    }
    
}
