//
//  UIColorCeibaTest.swift
//  Ceiba-Software-Challenge-Tests
//
//  Created by Kevin Marin on 25/11/23.
//

import XCTest
@testable import Ceiba_Software_Challenge

class UIColorCeibaTest: XCTestCase, TestUtils {
    var expAsync: XCTestExpectation!
    
    
    func test_initWithHexString_RGB12bit() {
        // Arrange
        expAsync = expectation(description: "waiting")
        let hexString = "#0F0"

        // Act
        let color = UIColor(hexString: hexString)

        // Assert
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        awaitExpAsync()

        XCTAssertEqual(red, 0.0, "Red component should be 1.0")
        XCTAssertEqual(green, 1.0, "Green component should be 1.0")
        XCTAssertEqual(blue, 0.0, "Blue component should be 1.0")
        XCTAssertEqual(alpha, 1.0, "Alpha component should be 1.0")
    }
    
    func test_initWithHexString_RGB24bit() {
        // Arrange
        expAsync = expectation(description: "waiting")
        let hexString = "#00FF00"

        // Act
        let color = UIColor(hexString: hexString)

        // Assert
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        awaitExpAsync()
        
        XCTAssertEqual(red, 0.0, "Red component should be 1.0")
        XCTAssertEqual(green, 1.0, "Green component should be 1.0")
        XCTAssertEqual(blue, 0.0, "Blue component should be 1.0")
        XCTAssertEqual(alpha, 1.0, "Alpha component should be 1.0")
    }
    
    func test_initWithHexString_RGB32bit() {
        // Arrange
        expAsync = expectation(description: "waiting")
        let hexString = "#00FF00FF"

        // Act
        let color = UIColor(hexString: hexString)

        // Assert
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
        awaitExpAsync()
    
        print(color.description)
        
        XCTAssertEqual(red, 0.0, "Red component should be 0.0")
        XCTAssertEqual(green, 1.0, "Green component should be 1.0")
        XCTAssertEqual(blue, 0.0, "Blue component should be 0.0")
        XCTAssertEqual(alpha, 1.0, "Alpha component should be 1.0")
    }
    
    func test_initWithHexString_default() {
        // Arrange
        expAsync = expectation(description: "waiting")
        let hexString = "#0"

        // Act
        let color = UIColor(hexString: hexString)

        // Assert
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    
        awaitExpAsync()
    
        print(color.description)
        
        XCTAssertEqual(red, 0.0, "Red component should be 0.0")
        XCTAssertEqual(green, 0.0, "Green component should be 1.0")
        XCTAssertEqual(blue, 0.0, "Blue component should be 0.0")
        XCTAssertEqual(alpha, 1.0, "Alpha component should be 1.0")
    }
}
