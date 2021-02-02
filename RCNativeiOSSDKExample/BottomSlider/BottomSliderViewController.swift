//
//  BottomSliderViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by user on 02.02.2021.
//  Copyright © 2021 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK

protocol BottomSliderViewable: UIViewController {
  var bannerId: String! { get set }
  var bannerSize: RCNativeSliderBanner.BannerSize! { get set }
}

class BottomSliderViewController: UIViewController, BottomSliderViewable {
  var bannerId: String!
  var bannerSize: RCNativeSliderBanner.BannerSize!
  
  lazy var bottomSlider: RCNativeSliderBanner = {
    let slider = RCNativeSliderBanner(bannerId: bannerId, size: bannerSize)
    slider.delegate = self
    slider.presentingController = self
    return slider
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bottomSlider.load()
  }
    
}

extension BottomSliderViewController: RCNativeSliderBannerDelegate {
  func sliderBannerDidLoad(_ banner: RCNativeSliderBanner){
    print("Banner: \(banner) did load")
  }
  func sliderBannerWillAppear(_ banner: RCNativeSliderBanner){
    print("Banner: \(banner) will appear")
  }
  func sliderBannerDidAppear(_ banner: RCNativeSliderBanner){
    print("Banner: \(banner) did appear")
  }
  func sliderBannerDidSelect(_ banner: RCNativeSliderBanner){
    print("Banner: \(banner) did select")
  }
  func sliderBannerWillClose(_ banner: RCNativeSliderBanner){
    print("Banner: \(banner) will close")
  }
  func sliderBannerDidClose(_ banner: RCNativeSliderBanner){
    print("Banner: \(banner) did close")
  }
}
