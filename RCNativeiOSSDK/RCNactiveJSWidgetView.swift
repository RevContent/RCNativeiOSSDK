//
//  RCJSWidgetView.swift
//  RCSampleApp
//
//  Created by Apple on 22/04/20.
//  Copyright © 2020 Team. All rights reserved.
//

import UIKit
import WebKit

private let defaultBaseURL = "https://performance.revcontent.dev/"
private let widgetHostKey = "{widget-host}"
private let widgetHostVal = "habitat"
private let endPointKey = "{endpoint}"
private let endPointVal = "trends.revcontent.com"
private let isSecuredKey = "{is-secured}"
private let isSecuredVal = "true"
private let jsSrcKey = "{js-src}"
private let jsSrcVal = "https://assets.revcontent.com/master/delivery.js"
private let deferKey = "{defer}"
private let deferVal = "defer"
private let widgetIdKey = "{widget-id}"
private let widgetSubIdKey = "{sub-ids}"
private let sourceUrlKey = "{source-url}"
private let gdpr = "{gdpr}"
private let gdprConsent = "{gdpr-consent}"
private let usPrivacy = "{CCPA_STRING}"



public class RCNactiveJSWidgetView: WKWebView {
  private var htmlWidget:String?
  private var widgetId:String?
  private var siteUrl:String?
  private var baseUrl:String?
  private var widgetSubId:[String:String]?
  private var isGDPREnabled: Bool?
  private var GDPRConsent: String?
  private var CCPAString: String?
  private var widgetLoadingDate: Date?
  
  private weak var containerView: UIView!
  
  lazy var heightConstraint: NSLayoutConstraint = {
    let constraint = NSLayoutConstraint(item: self,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1,
                                        constant: containerView.bounds.height)
    constraint.isActive = true
    return constraint
  }()
  
  static fileprivate var defaultConfiguration: WKWebViewConfiguration = {
    let configuration = WKWebViewConfiguration()
    configuration.preferences.javaScriptEnabled = true
    configuration.allowsInlineMediaPlayback = true
    configuration.mediaTypesRequiringUserActionForPlayback = .audio
    return configuration
  }()
  
  var heightHandler: RCNativeJSWidgetHeightHandler?
  public weak var delegate: RCNativeJSWidgetViewDelegate?
  
  
  public init(containerView: UIView,
              configuration: WKWebViewConfiguration? = nil) {
    super.init(frame: containerView.bounds, configuration: configuration ?? RCNactiveJSWidgetView.defaultConfiguration)
    backgroundColor = .clear
    navigationDelegate = self
    self.containerView = containerView
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    heightHandler?.stopObservingHeight()
    debugPrint("\(String(describing: self)): deinited")
  }
  
  private func loadHTMLContent(){
      self.htmlWidget =
      """
      <!doctype html>
      <html>
      <head>
      <style>
      html, body { margin:0; padding: 0; }
      
      @media (prefers-color-scheme: dark) {
      html, body {
      background: #000;
      }
      }
      </style>
      </head>
      <body>
      <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, user-scalable=no, shrink-to-fit=no\">
      <div id=\"rc-widget-27bbf8\" data-rc-widget data-widget-host=\"{widget-host}\" data-endpoint=\"{endpoint}\" data-is-secured=\"{is-secured}\" data-widget-id=\"{widget-id}\" data-gdpr=\"\(gdpr)\" data-gdpr-consent=\"\(gdprConsent)\" data-us-privacy=\"\(usPrivacy)\" data-sub-ids=\"{sub-ids}\">
      </div>
      <script src=\"{js-src}\" defer=\"{defer}\"></script>
      </body>
      </html>
      """
  }
  
  private func commonInit() {
    translatesAutoresizingMaskIntoConstraints = false;
    frame = containerView.bounds;
    containerView.addSubview(self);
    NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: containerView, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: containerView, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
    NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    scrollView.isScrollEnabled = false
    loadHTMLContent()
  }
  
  public func setWidgetId(widgetId:String){
    self.widgetId = widgetId
  }
  
  private func setSiteUrl(siteUrl:String){
    self.siteUrl = siteUrl
  }
  
  public func setBaseUrl(baseUrl:String){
    self.baseUrl = baseUrl
  }
  
  public func setWidgetSubId(widgetSubId:[String:String]){
    self.widgetSubId = widgetSubId
  }
  
  public func setWidgetId(widgetId:String, widgetSubId:[String:String]){
    self.widgetId = widgetId
    self.widgetSubId = widgetSubId
  }
  
  public func setGDPRConsent(_ consent: String?, isEnabled: Bool?) {
    isGDPREnabled = isEnabled
    GDPRConsent = consent
  }
  
  public func setCCPA(_ CCPAString: String?) {
    self.CCPAString = CCPAString
  }
  
  public func loadWidget() {
    if let message = validateWidget(){
      NSLog(message)
      return
    }
    self.loadHTMLString(generateWidgetHTML(),
                        baseURL: URL(string: baseUrl ?? defaultBaseURL))
    widgetLoadingDate = Date()
  }
    
  private func validateWidget() -> String? {
    if !RCNativeiOSSDK.initiliazed() {
      return "RCSDK -> SDK not initialzied."
    }
    if self.htmlWidget == nil {
      return "RCSDK -> RCJSWidgetView: Widget not loaded."
    }
    if self.widgetId == nil  {
      return "RCSDK -> RCJSWidgetView: WidgetId is required."
    }
    return nil
  }
  
  private func generateWidgetHTML() -> String {
    var result = self.htmlWidget!.replacingOccurrences(of: widgetHostKey, with: widgetHostVal)
    result = result.replacingOccurrences(of: endPointKey, with: endPointVal)
    result = result.replacingOccurrences(of: isSecuredKey, with: isSecuredVal)
    result = result.replacingOccurrences(of: widgetIdKey, with: self.widgetId!)
//        result = result.replacingOccurrences(of: sourceUrlKey, with: self.siteUrl!)
    result = result.replacingOccurrences(of: jsSrcKey, with: jsSrcVal)
    result = result.replacingOccurrences(of: deferKey, with: deferVal)
    result = result.replacingOccurrences(of: gdpr, with: "")
    if let isGDPREnabled = isGDPREnabled {
      result = result.replacingOccurrences(of: gdpr, with: isGDPREnabled ? "1" : "0")
    }
    result = result.replacingOccurrences(of: gdprConsent, with: GDPRConsent ?? "")
    result = result.replacingOccurrences(of: usPrivacy, with: CCPAString ?? "")
    
    if self.widgetSubId != nil {
      let jsonData = try? JSONSerialization.data(withJSONObject: self.widgetSubId!, options: [])
      let jsonString = String(data: jsonData!, encoding: .utf8)
      let replacedJsonString = jsonString!.replacingOccurrences(of: "\"", with: "&quot;")
      result = result.replacingOccurrences(of: widgetSubIdKey, with: replacedJsonString)
    } else {
      result = result.replacingOccurrences(of: widgetSubIdKey, with: "")
    }
    return result
  }
  
  public func clearCache() {
    if let date = widgetLoadingDate {
      URLCache.shared.removeCachedResponses(since: date)
      widgetLoadingDate = Date()
    }
  }
}

extension RCNactiveJSWidgetView: WKNavigationDelegate {
  public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    if navigationAction.navigationType == .linkActivated {
      guard let url = navigationAction.request.url else { decisionHandler(.allow); return }
      let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
      print (url)
      if components?.scheme == "http" || components?.scheme == "https" {
        UIApplication.shared.open(url)
        decisionHandler(.cancel)
      } else {
        decisionHandler(.allow)
      }
    } else if navigationAction.navigationType == .other {
      print (navigationAction.request.url as Any)
      decisionHandler(.allow)
    } else{
      decisionHandler(.allow)
    }
  }
  
  public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    if heightHandler == nil {
      let handler = RCNativeJSWidgetHeightHandler(widgetView: self)
      handler.heightDidChange = { [weak self] newHeight in
        guard let `self` = self else { return }
        self.heightConstraint.constant = newHeight
        self.layoutIfNeeded()
        self.delegate?.widgetView(self, didUpdateHeight: newHeight)
      }
      heightHandler = handler
    }
    heightHandler?.startObservingHeight()
  }
}

