//
//  BitSet.swift
//  BitSet
//
//  Created by Bernardo Breder on 06/01/17.
//
//

import XCTest
@testable import BitSet

class BitSetTests: XCTestCase {

	func test() throws {
        let bit = BitSet(count: 6)
        XCTAssertEqual(6, bit.count)
        XCTAssertEqual("000000", bit.description)
        bit.set(1)
        XCTAssertEqual("010000", bit.description)
        bit.set(3)
        XCTAssertEqual("010100", bit.description)
        bit.clear(1)
        XCTAssertEqual("000100", bit.description)
        XCTAssertTrue(bit.any1())
        XCTAssertTrue(bit.isSet(3))
        bit.clearAll()
        XCTAssertEqual("000000", bit.description)
        XCTAssertFalse(bit.any1())
	}

}

