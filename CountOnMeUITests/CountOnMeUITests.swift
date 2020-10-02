//
//  CountOnMeUITests.swift
//  CountOnMeUITests
//
//  Created by Fabrice Mourou on 02/10/2020.
//  Copyright © 2020 Vincent Saluzzo. All rights reserved.

// swiftlint:disable force_cast


import XCTest

@testable import CountOnMe

class CountOnMeUITests: XCTestCase {

    func testEqualButton() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["5"].tap()
        app.buttons["+"].tap()
        app.buttons["3"].tap()
        app.buttons["×"].tap()
        app.buttons["2"].tap()
        app.buttons["="].tap()
        
        XCTAssertEqual(app.textViews.element.value as! String, "5 + 3 × 2 = 11")

    }
    
    
    func testNumberPadsButtons() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        
        for padNumber in 0...9 {
            app.buttons[padNumber.description].tap()
        }

    
        let displayedOperationText = app.textViews.element.value as! String
        XCTAssertEqual(displayedOperationText, "123456789")

    }
    
    func testZeroPadButton() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["0"].tap()

    
        let displayedOperationText = app.textViews.element.value as! String
        XCTAssertEqual(displayedOperationText, "0")

    }
    
    func testMathOperatorsButtons() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let zeroNumberPadButton = app.buttons["0"]
        
        zeroNumberPadButton.tap()
        app.staticTexts["+"].tap()
        zeroNumberPadButton.tap()
        app.staticTexts["-"].tap()
        zeroNumberPadButton.tap()
        app.staticTexts["×"].tap()
        zeroNumberPadButton.tap()
        app.buttons["÷"].tap()
        
    
        let displayedOperationText = app.textViews.element.value as! String
        XCTAssertEqual(displayedOperationText, "0 + 0 - 0 × 0 ÷ ")

    }
    
    func testResetButton() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["0"].tap()
        app.buttons["C"].tap()
        
    
        let displayedOperationText = app.textViews.element.value as! String
        XCTAssertEqual(displayedOperationText, "")

    }
    
    func testOperatorErrorAlert() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["+"].tap()
        XCTAssertEqual(app.alerts.element.label, "🤷🏻‍♂️")
    
    }
    
    func testEqualErrorAlert() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["="].tap()
        XCTAssertEqual(app.alerts.element.label, "🤷🏻‍♂️")
    
    }
    

}
