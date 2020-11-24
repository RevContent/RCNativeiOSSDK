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
  
  lazy var widgetView: RCNactiveJSWidgetView = {
    let widget = RCNactiveJSWidgetView(containerView: viewWidget)
    // WidgetId is required.
    widget.setWidgetId(widgetId: widgetId)
    // WidgetSubId is optional.
    widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
    // baseUrl is optional.
    widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
    widget.setGDPRConsent("your_base64encoded-consent")
    widget.delegate = self
    return widget
  }()
  
  var widgetId : String!

  override func viewDidLoad() {
    super.viewDidLoad()
    RCNativeiOSSDK.setup()
    widgetView.loadWidget()
  }
}

extension WidgetViewController: RCNativeJSWidgetViewDelegate {
  func widgetView(_ widgetView: RCNactiveJSWidgetView, didUpdateHeight height: CGFloat) {
    // handle widgetView heigth changes
  }
}
