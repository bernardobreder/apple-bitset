//
//  BitSetReaderTests.swift
//  BitSet
//
//  Created by Bernardo Breder on 08/01/17.
//
//

import XCTest
@testable import BitSet

class BitSetReaderTests: XCTestCase {

    func testExample() {
        var array: [Bool] = []
        for i in BitSetReader(BitSet(count: 6).set(1).set(4)) {
            array.append(i)
        }
        XCTAssertEqual([false, true, false, false, true, false], array)
        XCTAssertEqual([true, true], BitSetReader(BitSet(count: 6).set(1).set(4)).filter({$0}))
        XCTAssertEqual([false, false, false, false], BitSetReader(BitSet(count: 6).set(1).set(4)).filter({!$0}))
    }
    
}
