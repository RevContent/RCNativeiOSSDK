//
//  ShowWidgetViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Mayank Palotra on 13/07/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK

class ShowWidgetViewController: UIViewController {

    // Instance
    var widgetCount = 0
    var statusBarHeight: CGFloat = 0
    let widgetID = ["66620","66620","66620","66620","66620","66620","66620","66620"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Status Bar Height
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        // Naviagtion Bar Height
        let navBarHeight = statusBarHeight +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
        
        // Device Height
        let deviceHeight = self.view.bounds.height - navBarHeight
        
        // Create Widget on views
        for i in 0..<widgetCount
        {
            let Yvalue = CGFloat(i)*deviceHeight/CGFloat(widgetCount)
            let viewWidget = UIView.init(frame: CGRect(x: 0, y: (Yvalue + navBarHeight) , width: self.view.bounds.width, height: deviceHeight/CGFloat(widgetCount)))
            viewWidget.backgroundColor = .random()
            viewWidget.addSubview(self.createWidget(widgetID[i]))
            self.view.addSubview(viewWidget)
        }
    }
    
    // RCNactiveJSWidgetView For Ad
    func createWidget(_ widId : String) -> RCNactiveJSWidgetView
    {
        RCNativeiOSSDK.setup()
        let widget = RCNactiveJSWidgetView.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/CGFloat(widgetCount)))
        // WidgetId is required.
        widget.backgroundColor = .random()
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
// Random color to define rows
extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
