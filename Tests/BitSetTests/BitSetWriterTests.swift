//
//  BitSetWriterTests.swift
//  BitSet
//
//  Created by Bernardo Breder on 08/01/17.
//
//

import XCTest
@testable import BitSet

class BitSetWriterTests: XCTestCase {

    func testExample() {
        XCTAssertEqual(BitSet(count: 6).set(1).set(4).description, BitSetWriter().unset().set().unset().unset().set().unset().bitSet().description)
        XCTAssertEqual(BitSet(count: 8).set(1).set(3).set(6).description, BitSetWriter().unset().set().set(bitSet: BitSetWriter().unset().set().unset().unset().set().unset().bitSet()).bitSet().description)
    }

}
