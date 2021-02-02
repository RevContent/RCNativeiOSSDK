//
//  WidgetViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK

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
    // GDPR is optional
    widget.setGDPRConsent("put_your_base64encoded_consent", isEnabled: nil)
    // CCPA is optional
    widget.setCCPA("put_your_CCPA_consent_string")
    widget.delegate = self
    return widget
  }()
  
  lazy var bannerView: RCNativeSliderBanner = {
    let banner = RCNativeSliderBanner(bannerId: "1233", size: .preset160x600)
    banner.presentingController = self
    return banner
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
    // handle widgetView height changes
  }
}

