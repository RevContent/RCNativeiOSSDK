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
      return UIImage(named: name, in: podBundle, compatibleWith: nil)
  }
}
