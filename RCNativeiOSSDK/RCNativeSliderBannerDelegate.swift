//
//  RCNativeSliderBannerDelegate.swift
//  RCNativeiOSSDK
//
//  Created by user on 25.01.2021.
//  Copyright © 2021 Revcontent. All rights reserved.
//

import Foundation

public protocol RCNativeSliderBannerDelegate: class {
  func sliderBannerDidLoad(_ banner: RCNativeSliderBanner)
  func sliderBannerWillAppear(_ banner: RCNativeSliderBanner)
  func sliderBannerDidAppear(_ banner: RCNativeSliderBanner)
  func sliderBannerDidSelect(_ banner: RCNativeSliderBanner)
  func sliderBannerWillClose(_ banner: RCNativeSliderBanner)
  func sliderBannerDidClose(_ banner: RCNativeSliderBanner)
}

public extension RCNativeSliderBannerDelegate {
  func sliderBannerDidLoad(_ banner: RCNativeSliderBanner){}
  func sliderBannerWillAppear(_ banner: RCNativeSliderBanner){}
  func sliderBannerDidAppear(_ banner: RCNativeSliderBanner){}
  func sliderBannerDidSelect(_ banner: RCNativeSliderBanner){}
  func sliderBannerWillClose(_ banner: RCNativeSliderBanner){}
  func sliderBannerDidClose(_ banner: RCNativeSliderBanner){}
}
