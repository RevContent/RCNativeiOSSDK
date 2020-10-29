//
//  RCNativeJSWidgetViewDelegate.swift
//  RCNativeiOSSDK
//
//  Created by user on 29.10.2020.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import WebKit

public protocol RCNativeJSWidgetViewDelegate: class {
  func widgetView(_ widgetView: RCNactiveJSWidgetView, didUpdateHeight height: CGFloat)
}
