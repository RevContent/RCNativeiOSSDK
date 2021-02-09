//
//  BottomSlidersViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by user on 02.02.2021.
//  Copyright © 2021 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK

class BottomSlidersViewController: UITableViewController {

  let dataSource = RCNativeSliderBanner.BannerSize.allCases
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "sliderCell", for: indexPath)
    cell.textLabel?.text = dataSource[indexPath.row].rawValue
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let bottomSliderVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: BottomSliderViewController.self)) as? BottomSliderViewable {
      bottomSliderVC.bannerId = "1233"
      bottomSliderVC.bannerSize = dataSource[indexPath.row]
      navigationController?.pushViewController(bottomSliderVC, animated: true)
    }
  }
}
