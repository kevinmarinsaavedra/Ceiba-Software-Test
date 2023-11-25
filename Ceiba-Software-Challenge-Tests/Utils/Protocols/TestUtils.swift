//
//  TestUtils.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 10/11/23.
//
import XCTest

protocol TestUtils: XCTestCase {
    var expAsync: XCTestExpectation! { get set }
}

extension TestUtils {
    
    func awaitExpAsync(deadline: TimeInterval = 0.2, timeOut: TimeInterval = 5.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + deadline) { [self] in
            expAsync.fulfill()
        }
        
        waitForExpectations(timeout: timeOut)
    }
}

