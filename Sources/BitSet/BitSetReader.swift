//
//  BitSetReader.swift
//  BitSet
//
//  Created by Bernardo Breder on 08/01/17.
//
//

import Foundation

public class BitSetReader: Sequence {
    
    let bitSet: BitSet
    
    public init(_ bitSet: BitSet) {
        self.bitSet = bitSet
    }
    
    public func makeIterator() -> BitSetIterator {
        return BitSetIterator(bitSet)
    }
    
}

public class BitSetIterator : IteratorProtocol {
    
    typealias Word = UInt64
    
    let bitSet: BitSet
    
    var word: Int = 0
    
    var item: Int = 0
    
    var index: Int = 0
    
    public init(_ bitSet: BitSet) {
        self.bitSet = bitSet
    }
    
    public func next() -> Bool? {
        guard index < bitSet.count else { return nil }
        if item == bitSet.N {
            item = 0
            word += 1
        }
        let next = bitSet.words[word] & (1 << Word(item)) != 0
        item += 1
        index += 1
        return next
    }
    
}
