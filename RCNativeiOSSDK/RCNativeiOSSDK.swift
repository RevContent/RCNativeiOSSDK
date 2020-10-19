//
//  RCSDK.swift
//  RCSampleApp
//
//  Created by Apple on 22/04/20.
//  Copyright © 2020 Team. All rights reserved.
//

import UIKit

public final class RCNativeiOSSDK: NSObject {
  private static var instance: RCNativeiOSSDK!
  private var initiliazed = false
  
  private override init() {}
  
  public class func setup(){
    if instance == nil {
      instance = RCNativeiOSSDK()
    }
  }
  
  private class func validateSDK() -> Bool {
    return instance != nil
  }
  
  public class func initiliazed() -> Bool {
    return validateSDK()
  }
}
