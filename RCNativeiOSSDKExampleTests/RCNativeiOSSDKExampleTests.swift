//
//  RCNativeiOSSDKExampleTests.swift
//  RCNativeiOSSDKExampleTests
//
//  Created by user on 24.11.2020.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import XCTest
import RCNativeiOSSDK


class RCNativeiOSSDKExampleTests: XCTestCase {

  let widgetId = "168069"
  let containerView = UIView()
  lazy var widgetView: RCNactiveJSWidgetView = {
    let widgetView = RCNactiveJSWidgetView(containerView: containerView)
    RCNativeiOSSDK.setup()
    widgetView.setWidgetId(widgetId: widgetId)
    widgetView.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
    widgetView.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
    return widgetView
  }()
  let loadingExpectation = XCTestExpectation(description: "Widget view content loading expectation")
  let widgetHeightExpectation = XCTestExpectation(description: "Widget view content height expectation")

  override func setUp() {
    super.setUp()
    widgetView.loadWidget()
  }
  
  func testWidgetIdEquality() throws {
      XCTAssert(!widgetId.isEmpty, "Widget id is empty.")
      Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
        self.widgetView.evaluateJavaScript("document.documentElement.outerHTML") { [weak self] (html, error) in
          if let html = html as? String {
            if let lastComponent = html.components(separatedBy: "data-widget-id=").last,
               lastComponent.hasPrefix("\"\(self?.widgetId ?? "")\"") {
              self?.loadingExpectation.fulfill()
              timer.invalidate()
            }
          }
        }
      }
      wait(for: [loadingExpectation], timeout: 60)
  }
  
  

  func testHeight() throws {
    XCTAssert(!widgetId.isEmpty, "Widget id is empty.")
    Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
      self.widgetView.evaluateJavaScript("document.body.scrollHeight", completionHandler: { [weak self] (result, error) in
        guard let height = result as? CGFloat else { return }
        if height > 0 {
          self?.widgetHeightExpectation.fulfill()
          timer.invalidate()
        }
      })
    }
    wait(for: [widgetHeightExpectation], timeout: 60)
  }
}
