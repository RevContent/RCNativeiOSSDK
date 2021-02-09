//
//  AnotherWidgetViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Mayank Palotra on 17/09/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK

class AnotherWidgetViewController: UIViewController, WidgetViewable {

  // MARK:- @IBOutlet's & Connections
  @IBOutlet var viewWidget : UIView!
  @IBOutlet var lblUppertext : UILabel!
  @IBOutlet var lblLowertext : UILabel!

  lazy var widgetView: RCNactiveJSWidgetView = {
    let widget = RCNactiveJSWidgetView(containerView: viewWidget)
    // WidgetId is required.
    widget.setWidgetId(widgetId: widgetId)
    // WidgetSubId is optional.
    widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
    // baseUrl is optional.
    widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
    return widget
  }()
  
  var widgetId : String!

  override func viewDidLoad() {
    super.viewDidLoad()
    RCNativeiOSSDK.setup()
    widgetView.loadWidget()
  }
}
