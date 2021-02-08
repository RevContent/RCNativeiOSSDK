//
//  UIImage+Extension.swift
//  RCNativeiOSSDK
//
//  Created by user on 25.01.2021.
//  Copyright © 2021 Revcontent. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
  static func image(_ name: String) -> UIImage? {
    let podBundle = Bundle(for: RCNativeiOSSDK.self)
    if let url = podBundle.url(forResource: "RCNativeiOSSDK", withExtension: "bundle") {
      let bundle = Bundle(url: url)
      return UIImage(named: name, in: bundle, compatibleWith: nil)
    }
    return nil
//      return UIImage(named: name, in: podBundle, compatibleWith: nil)
  }
}
