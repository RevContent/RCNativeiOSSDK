//
//  RCNativeiOSSDKExampleUITests.swift
//  RCNativeiOSSDKExampleUITests
//
//  Created by user on 24.11.2020.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import XCTest

class RCNativeiOSSDKExampleUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
      let app = XCUIApplication()
      app.launch()
      
      app.tables.staticTexts["  1x1 Bottom"].tap()
      let webView = app.webViews.element(boundBy: 0)
      XCTAssert(webView.waitForExistence(timeout: 5), "WebView doesn't loaded. Could be caused by wrong widget_id")
      XCTAssert(webView.frame.size != .zero, "Widget size equal zero: something went wrong")

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testLaunchPerformance() throws {
//        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
//            // This measures how long it takes to launch your application.
//            measure(metrics: [XCTApplicationLaunchMetric()]) {
//                XCUIApplication().launch()
//            }
//        }
//    }
}
