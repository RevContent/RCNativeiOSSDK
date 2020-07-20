//
//  ShowWidgetViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Mayank Palotra on 13/07/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK
import WebKit

class ShowWidgetViewController: UIViewController {

    // Instance of ShowWidgetViewController
    var widgetCount = 0 // Count of widget display on view.
    var statusBarHeight: CGFloat = 0 // For Status Bar Height
    let widgetID = ["144705", "144703","144704","144705","144706","144707","144708","144709","144710", "144711","144712","144713","144750","144751","144752","144754","144755","144756","144757", "144758","144760","144761"] // Widget ID's array for showing multiple diffrent widget on diffrent sizes.

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
        DispatchQueue.main.async {
            for i in 0..<self.widgetCount
            {
                print((self.widgetID[(self.widgetCount-1)]))
                let Yvalue = CGFloat(i)*deviceHeight/CGFloat(self.widgetCount)
                let viewWidget = UIView.init(frame: CGRect(x: 0, y: (Yvalue + navBarHeight) , width: self.view.bounds.width, height: deviceHeight/CGFloat(self.widgetCount)))
                viewWidget.backgroundColor = .random()
                viewWidget.addSubview(self.createWidget(self.widgetID[(self.widgetCount-1)]))
                self.view.addSubview(viewWidget)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        // Get All Cookies list of visited widets.
        if #available(iOS 11, *) {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.httpCookieStore.getAllCookies({ (cookies) in
                print(cookies)
            })
        } else {
            guard let cookies = HTTPCookieStorage.shared.cookies else {
                return
            }
            print(cookies)
        }
    }

    // Creat Widget function of RCNactiveJSWidgetView For Ad
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
// Random color function to define rows
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
