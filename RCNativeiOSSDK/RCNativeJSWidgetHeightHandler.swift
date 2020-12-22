//
//  RCNativeJSWidgetHeightHandler.swift
//  RCNativeiOSSDK
//
//  Created by user on 15.10.2020.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import Foundation
import UIKit

class RCNativeJSWidgetHeightHandler: NSObject {
  weak var widgetView: RCNactiveJSWidgetView?
  private var isHeightAdjusted = false
  private var oldHeight = CGFloat.zero
  private var timesMatched = 0
  var heightDidChange: ((CGFloat)->())?
  
  init(widgetView: RCNactiveJSWidgetView?) {
    self.widgetView = widgetView
  }
  
  deinit {
    debugPrint("\(String(describing: self)): deinited")
  }
  
  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?)  {
    guard widgetView?.scrollView.contentSize.height != oldHeight else {
      //FIXME: workaround, because of wrong scrollView.content Size in case allowsInlineMediaPlayback enabled
      if timesMatched >= 15, !isHeightAdjusted {
        evaluateHeightScript()
        return
      }
      timesMatched += 1
      return
    }
    isHeightAdjusted = false
    timesMatched = 0
    oldHeight = widgetView?.scrollView.contentSize.height ?? 0
    if !isHeightAdjusted {
      heightDidChange?(oldHeight)
    }
//    print("height content: \(widgetView?.scrollView.contentSize.height)")
  }
  
  func startObservingHeight() {
    widgetView?.scrollView.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
  }
  
  func stopObservingHeight() {
    widgetView?.scrollView.removeObserver(self, forKeyPath: "contentSize")
  }
  
  private func evaluateHeightScript() {
    widgetView?.evaluateJavaScript("document.body.scrollHeight", completionHandler: { [weak self] (result, error) in
      guard let height = result as? CGFloat else { return }
//      print("height: \(height)")
      self?.heightDidChange?(height)
      self?.isHeightAdjusted = true
    })
  }
}
