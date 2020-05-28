//
//  ViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Apple on 21/05/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       RCNativeiOSSDK.setup()
               let widget = RCNactiveJSWidgetView.init(frame: self.view.frame)
               // WidgetId is required.
        widget.setWidgetId(widgetId: "66620")
               // WidgetSubId is optional.
               widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
               // baseUrl is optional.
               widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
               self.view.addSubview(widget)
               widget.loadWidget()
        // Do any additional setup after loading the view.
    }


}

