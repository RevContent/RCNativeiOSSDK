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

class AnotherWidgetViewController: UIViewController, WKNavigationDelegate {

    // MARK:- @IBOutlet's & Connections
    @IBOutlet weak var viewWidget : UIView!
    @IBOutlet weak var lblUppertext : UILabel!
    @IBOutlet weak var lblLowertext : UILabel!
    @IBOutlet weak var heightView : NSLayoutConstraint!
    @IBOutlet weak var heightlblUppertext : NSLayoutConstraint!
    @IBOutlet weak var heightViewWidget : NSLayoutConstraint!
    @IBOutlet weak var heightlblLowertext : NSLayoutConstraint!

    // MARK:- Instance
    lazy var webView: WKWebView = {
        guard
          let path = Bundle.main.path(forResource: "style", ofType: "css"),
          let cssString = try? String(contentsOfFile: path).components(separatedBy: .newlines).joined()
        else {
          return WKWebView()
        }

        let source = """
           var style = document.createElement('style');
           style.innerHTML = '\(cssString)';
           document.head.appendChild(style);
        """

        let userScript = WKUserScript(source: source,
                                      injectionTime: .atDocumentEnd,
                                      forMainFrameOnly: true)

        let userContentController = WKUserContentController()
        userContentController.addUserScript(userScript)

        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController

        let webView = WKWebView(frame: .zero,
                                configuration: configuration)
        return webView
    }()
    var widgetId : String!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        RCNativeiOSSDK.setup()
        webView = self.createWidget(widgetId)
        webView.navigationDelegate = self
        self.viewWidget.addSubview(webView)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews()
    {
        super.viewWillLayoutSubviews()
        let font = UIFont(name: "Helvetica", size: 17.0)!
        let heightUpperText = heightForView(text: lblUppertext.text!, font: font, width: self.view.frame.size.width)
        let heightLowerText = heightForView(text: lblLowertext.text!, font: font, width: self.view.frame.size.width)
        self.heightlblUppertext.constant = heightUpperText + 20
        self.heightlblLowertext.constant = heightLowerText + 20

        self.heightView.constant = heightUpperText + heightLowerText + 40 + self.heightViewWidget!.constant
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
        let heightView = widget.scrollView.contentSize.height
        print(heightView)
        return widget
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.isLoading == false {
            webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: {(result, error) in
                webView.invalidateIntrinsicContentSize()
                if let height = result as? CGFloat {
                    webView.frame.size.height += height + 300
                    let height = webView.frame.size.height
                    self.heightViewWidget?.constant = height
                    self.viewWillLayoutSubviews()
                }
            })
        }
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude)) //(0, 0, width, CGFloat.greatestFiniteMagnitude)
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
}
