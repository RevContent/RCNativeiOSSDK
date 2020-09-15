//
//  WidgetViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK

class WidgetViewController: UIViewController {

    @IBOutlet weak var viewWidget : UIView!
    var widgetId : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RCNativeiOSSDK.setup()
        self.viewWidget.addSubview(self.createWidget(widgetId))
        // Do any additional setup after loading the view.
    }
    
    func createWidget(_ widId : String) -> RCNactiveJSWidgetView
    {
        let widget = RCNactiveJSWidgetView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        // WidgetId is required.
        widget.setWidgetId(widgetId: widId)
        // WidgetSubId is optional.
        widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
        // baseUrl is optional.
        widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
        //self.view.addSubview(widget)
        widget.loadWidget()
        return widget
    }
}
