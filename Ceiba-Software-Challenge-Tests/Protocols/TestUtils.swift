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
    
    func awaitExpAsync(timeOut: TimeInterval = 1.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [self] in
            expAsync.fulfill()
        }
        
        waitForExpectations(timeout: timeOut)
    }
}

