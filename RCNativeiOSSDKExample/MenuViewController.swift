//
//  MenuViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by user on 02.02.2021.
//  Copyright © 2021 Revcontent. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

  let dataSource = ["Widgets", "Bottom sliders"]
  
  private var mainStoryboard: UIStoryboard {
    return UIStoryboard(name: "Main", bundle: nil)
  }
  
  override func viewDidLoad() {
      super.viewDidLoad()
  }


  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
    cell.textLabel?.text = dataSource[indexPath.row]
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var selectedVC: UIViewController?
    switch indexPath.row {
      case 0:
        selectedVC = mainStoryboard
          .instantiateViewController(withIdentifier: String(describing: WidgetsViewController.self))
      case 1:
        selectedVC = mainStoryboard
          .instantiateViewController(withIdentifier: String(describing: BottomSlidersViewController.self))
      default:
        break
    }
    if let selectedVC = selectedVC {
      navigationController?.pushViewController(selectedVC, animated: true)
    }
  }
}
