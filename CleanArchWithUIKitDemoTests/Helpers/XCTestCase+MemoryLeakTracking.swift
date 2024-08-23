//
//  XCTestCase+MemoryLeakTracking.swift
//  CleanArchWithUIKitDemoTests
//
//  Created by Jill Chang on 2024/8/21.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
