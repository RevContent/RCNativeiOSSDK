//
//  RCNativeSliderBanner.swift
//  RCNativeiOSSDK
//
//  Created by user on 25.01.2021.
//  Copyright © 2021 Revcontent. All rights reserved.
//

import Foundation
import UIKit
import WebKit

public class RCNativeSliderBanner: NSObject {
  let bannerId: String
  let size: RCNativeSliderBanner.BannerSize
  public weak var presentingController: UIViewController?
  public weak var delegate: RCNativeSliderBannerDelegate?
  var heightHandler: RCNativeJSWidgetHeightHandler?

  lazy var containerView: UIView = {
    guard let presentingController = presentingController else { fatalError("RCNativeSliderBanner: presentingController hasn't set") }
    let container = UIView()
    container.backgroundColor = .clear
    container.translatesAutoresizingMaskIntoConstraints = false
    presentingController.view.addSubview(container)
    presentingController.view.bringSubviewToFront(container)
    
    container.centerXAnchor.constraint(equalTo: presentingController.view.centerXAnchor).isActive = true
    
    container.addSubview(closeButton)
    closeButton.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    closeButton.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
    closeButton.heightAnchor.constraint(equalToConstant: closeButtonSize.height).isActive = true
    closeButton.widthAnchor.constraint(equalToConstant: closeButtonSize.width).isActive = true
    
    container.addSubview(bannerView)
    bannerView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    bannerView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
    bannerView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    bannerView.topAnchor.constraint(equalTo: closeButton.bottomAnchor).isActive = true
    
    return container
  }()
  
  lazy var bannerView: WKWebView = {
    let webView = WKWebView()
    webView.translatesAutoresizingMaskIntoConstraints = false
    webView.navigationDelegate = self
    webView.scrollView.isScrollEnabled = false
    webView.contentMode = .scaleAspectFit
    return webView
  }()
  
  lazy var closeButton: UIButton = {
    let button = UIButton()
    let buttonColor = UIColor(red: 111/255, green: 110/255, blue: 111/255, alpha: 1)
    
    button.setImage(UIImage.image("closeIcon"), for: .normal)
    button.tintColor = buttonColor
    button.addTarget(self, action: #selector(closeButtonTapped(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .white
    button.layer.cornerRadius = 2
    button.layer.masksToBounds = true
    button.layer.borderWidth = 1
    button.layer.borderColor = buttonColor.cgColor
    return button
  }()
  
  lazy var bannerTopConstraint: NSLayoutConstraint = {
    let constraint = NSLayoutConstraint(item: containerView,
                                        attribute: .top,
                                        relatedBy: .equal,
                                        toItem: presentingController?.view,
                                        attribute: .bottom,
                                        multiplier: 1,
                                        constant: 0)
    constraint.isActive = true
    return constraint
  }()
  
  lazy var bannerViewHeightConstraint: NSLayoutConstraint = {
    let constraint = NSLayoutConstraint(item: bannerView,
                                        attribute: .height,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1, constant: .zero)
    constraint.isActive = true
    return constraint
  }()
  
  lazy var bannerViewWidthConstraint: NSLayoutConstraint = {
    let constraint = NSLayoutConstraint(item: containerView,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1, constant: .zero)
    constraint.isActive = true
    return constraint
  }()
  
  var containerViewHeight: CGFloat {
    return min(parentView.bounds.height-closeButtonSize.height-parentView.safeAreaInsets.top,
               size.size.height+closeButtonSize.height)
  }
  
  var containerViewWidth: CGFloat {
    return min(parentView.bounds.width, size.size.width)
  }
  
  var parentView: UIView {
    guard let presentingController = presentingController else { fatalError("RCNativeSliderBanner: presentingController hasn't set") }
    return presentingController.view
  }
  
  let closeButtonSize = CGSize(width: 24, height: 24)
  var isBannerLoaded = false
  var isBannerShown = false
  /// change to false in case manual presenting banner
  public var showImmediatelyAfterLoad = true

  
  public init(bannerId: String, size: RCNativeSliderBanner.BannerSize) {
    self.bannerId = bannerId
    self.size = size
  }
  
  
  deinit {
    heightHandler?.stopObservingHeight()
    debugPrint("\(String(describing: self)): deinited")
  }
  
  var html: String {
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
    <meta name=\"viewport\" content=\"width=\(size.size.width), initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no\">
      <div id=\"\(widgetHostVal)\" data-rc-widget="" data-widget-host=\"\(widgetHostVal)\" data-widget-id=\"\(bannerId)\" data-gdpr="" data-gdpr-consent="" data-us-privacy="" data-banner-size=\"\(size.sizeString)\" data-endpoint=\"\(endPointVal)\">
    </div>
    <script src=\"\(jsSrcVal)\" defer=\"\(deferVal)\"></script>
    </body>
    </html>
    """
  }
  
  public func load() {
    DispatchQueue.main.async { [weak self] in
      guard let `self` = self else { return }
      if self.isBannerLoaded {
        self.show()
        return
      }
      self.bannerView.loadHTMLString(self.html, baseURL: URL(string: defaultBaseURL))
      self.bannerTopConstraint.constant = .zero
      self.bannerViewWidthConstraint.constant = self.containerViewWidth
      self.presentingController?.view.layoutIfNeeded()
    }
  }
  
  
  public func show() {
    if isBannerShown {
      presentingController?.view.bringSubviewToFront(containerView)
      return
    }
    if isBannerLoaded {
      animateBanner(isClosing: false, duration: 0.3)
    }
  }
  
  
  public func hide() {
    if !isBannerShown { return }
    animateBanner(isClosing: true, duration: 0.3)
  }
  
  
  @objc private func closeButtonTapped(_ sender: UIButton) {
    hide()
  }
  
  
  private func animateBanner(isClosing: Bool, duration: Double) {
    presentingController?.view.bringSubviewToFront(containerView)
    let constant: CGFloat = isClosing ? 0 : -containerViewHeight
    bannerTopConstraint.constant = constant
    
    isClosing ? delegate?.sliderBannerWillClose(self) :
      delegate?.sliderBannerWillAppear(self)
    
    UIView.animate(withDuration: duration) { [weak self] in
      guard let `self` = self else { return }
      self.presentingController?.view.layoutIfNeeded()
      self.isBannerShown = !isClosing
    } completion: { [weak self] (_) in
      guard let `self` = self else { return }
      isClosing ? self.delegate?.sliderBannerDidClose(self) :
        self.delegate?.sliderBannerDidAppear(self)
    }
  }
  
  
  private func updateScaling() {
    if containerViewWidth < size.size.width || containerViewHeight < size.size.height {
      let widthRatio = containerViewWidth / bannerView.scrollView.contentSize.width
      let heightRatio = (containerViewHeight - closeButtonSize.height) / bannerView.scrollView.contentSize.height
      let scale = min(widthRatio, heightRatio)
      bannerView.scrollView.transform = CGAffineTransform(scaleX: scale, y: scale)
      bannerViewWidthConstraint.constant = bannerView.scrollView.contentSize.width * scale
      bannerViewHeightConstraint.constant = bannerView.scrollView.contentSize.height * scale
      if isBannerShown {
        bannerTopConstraint.constant = -(bannerViewHeightConstraint.constant + closeButtonSize.height)
      }
      presentingController?.view.layoutIfNeeded()
    }
  }
  
  
  @frozen
  public enum BannerSize: String, CaseIterable {
    case preset160x600, preset240x400, preset250x250, preset300x50, preset300x250, preset300x600, preset300x1050, preset320x50, preset336x280, preset640x1136, preset728x90, preset720x300, preset750x1334, preset970x250, preset970x500, preset1080x1920
    
    var sizeString: String {
      guard let sizeString = self.rawValue.components(separatedBy: "preset").last else { fatalError("Unexpected enum case") }
      return sizeString
    }
    
    var size: CGSize {
      let sizeComponents = sizeString.components(separatedBy: "x")
      guard let widthString = sizeComponents.first,
            let width = Double(widthString),
            let heightString = sizeComponents.last,
            let height = Double(heightString) else { fatalError("Unexpected enum case")  }
      return CGSize(width: width, height: height)
    }
  }
}


extension RCNativeSliderBanner: WKNavigationDelegate {
  public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    if navigationAction.navigationType == .linkActivated {
      guard let url = navigationAction.request.url else { decisionHandler(.allow); return }
      UIApplication.shared.open(url)
      delegate?.sliderBannerDidSelect(self)
    }
    decisionHandler(.allow)
  }
  
  
  public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    if heightHandler == nil {
      let handler = RCNativeJSWidgetHeightHandler(widgetView: webView)
      handler.heightDidChange = { [weak self] newHeight in
        guard let `self` = self else { return }
        if newHeight > 0 {
          if !self.isBannerLoaded {
            self.isBannerLoaded = true
            self.delegate?.sliderBannerDidLoad(self)
            if self.showImmediatelyAfterLoad {
              self.show()
            }
          }
          self.bannerViewHeightConstraint.constant = newHeight
          self.presentingController?.view.layoutIfNeeded()
          self.updateScaling()
        }
      }
      heightHandler = handler
    }
    heightHandler?.startObservingHeight()
  }
}
