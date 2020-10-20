//
//  WidgetViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK
import WebKit

class WidgetViewController: UIViewController, WidgetViewable {
  // MARK:- @IBOutlet's & Connections
  @IBOutlet var viewWidget : UIView!
  @IBOutlet var lbltext : UILabel!
  
  var webView: RCNactiveJSWidgetView!
  var widgetId : String!
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    RCNativeiOSSDK.setup()
    webView = self.createWidget(widgetId, containerView: viewWidget)
    webView.loadWidget()
  }

  func createWidget(_ widId : String, containerView: UIView) -> RCNactiveJSWidgetView {
    //init with default WKWebViewConfiguration
    let widget = RCNactiveJSWidgetView(containerView: containerView)
    // WidgetId is required.
    widget.setWidgetId(widgetId: widId)
    // WidgetSubId is optional.
    widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
    // baseUrl is optional.
    widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
    return widget
  }
}

