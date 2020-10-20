//
//  AnotherWidgetViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Mayank Palotra on 17/09/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK
import WebKit

class AnotherWidgetViewController: UIViewController, WidgetViewable {

  // MARK:- @IBOutlet's & Connections
  @IBOutlet var viewWidget : UIView!
  @IBOutlet var lblUppertext : UILabel!
  @IBOutlet var lblLowertext : UILabel!

  var webView: RCNactiveJSWidgetView!
  var widgetId : String!

  override func viewDidLoad() {
    super.viewDidLoad()
    RCNativeiOSSDK.setup()
    webView = self.createWidget(widgetId, containerView: viewWidget)
    webView.loadWidget()
  }
  
  func createWidget(_ widId : String, containerView: UIView) -> RCNactiveJSWidgetView {
    //init with custom WKWebViewConfiguration
    let widget = RCNactiveJSWidgetView(containerView: containerView)//RCNactiveJSWidgetView(containerView: containerView, configuration: webViewConfiguration)
    // WidgetId is required.
    widget.setWidgetId(widgetId: widId)
    // WidgetSubId is optional.
    widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
    // baseUrl is optional.
    widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
    return widget
  }
}
