//
//  SwiftyRegexTests.swift
//  SwiftyRegexTests
//
//  Created by Tyler Long on 7/3/16.
//  Copyright © 2016 Tylingsoft. All rights reserved.
//

import XCTest
@testable import SwiftyRegex

class SwiftyRegexTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMatch() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert("123456" =~ "^\\d+$")
        XCTAssert("123456" =~ "123456")
        XCTAssert("🐶🐶🐶🐶🐶🐶" =~ "🐶🐶🐶🐶🐶🐶")
    }
    
    func testSub() {
        XCTAssertEqual("2bb", "bbb".sub("b", withString: "2"))
    }
    
    func testGsub() {
        XCTAssertEqual("222", "bbb".gsub("b", withString: "2"))
    }
    
    func testScan() {
        XCTAssertEqual(["123", "456", "7890"], "(123) 456-7890".scan("\\d+"))
    }
    
    func testSplit() {
        XCTAssertEqual(["aaa", "bbb", "ccc", "ddd"], "aaa123bbb456ccc789ddd".split("\\d+"))
        XCTAssertEqual(["", "aaa", "bbb", "ccc", "ddd"], "0aaa123bbb456ccc789ddd".split("\\d+"))
        XCTAssertEqual(["aaa", "bbb", "ccc", "ddd"], "0aaa123bbb456ccc789ddd10".split("\\d+", removeEmptyEntries: true))
    }

    func testUnicode() {
        XCTAssertEqual(1, "🐶".characters.count)
        XCTAssertEqual(4, "🐶".utf8.count)
        XCTAssertEqual(2, "🐶".utf16.count)
        XCTAssertEqual(1, "a".characters.count)
        XCTAssertEqual(1, "a".utf8.count)
        XCTAssertEqual(1, "a".utf16.count)
        XCTAssertEqual(["Hello", "World"], "!Hello~`!@#$%^&*()_+={}[]|\\;:'\"<>,.?/World! こんにちは! สวัสดี! مرحبا! 您好!".split("[^A-Za-z]+", removeEmptyEntries: true))
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
