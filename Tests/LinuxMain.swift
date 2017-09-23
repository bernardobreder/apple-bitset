//
//  BitSetTests.swift
//  BitSet
//
//  Created by Bernardo Breder.
//
//

import XCTest
@testable import BitSetTests

extension BitSetTests {

	static var allTests : [(String, (BitSetTests) -> () throws -> Void)] {
		return [
			("test", test),
		]
	}

}

extension BitSetReaderTests {

	static var allTests : [(String, (BitSetReaderTests) -> () throws -> Void)] {
		return [
			("testExample", testExample),
		]
	}

}

extension BitSetWriterTests {

	static var allTests : [(String, (BitSetWriterTests) -> () throws -> Void)] {
		return [
			("testExample", testExample),
		]
	}

}

XCTMain([
	testCase(BitSetTests.allTests),
	testCase(BitSetReaderTests.allTests),
	testCase(BitSetWriterTests.allTests),
])

