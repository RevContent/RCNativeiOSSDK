//
//  MenuViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK

protocol WidgetViewable: UIViewController {
  var widgetId: String! { get set }
}

class MenuViewController: UIViewController {

  var dataSource = [(String, String)]()
  let data =
  """
    1x1 - 168069
    1x2 - 168070
    1x3 - 168071
    1x4 - 168072
    1x5 - 168073
    1x6 - 168074
    1x7 - 168075
    1x8 - 168076
    1x9 - 168077
    1x10 - 168078
    1x11 - 168079
    1x12 - 168080
    1x13 - 168081
    1x14 - 168083
    1x15 - 168084
    1x16 - 168085
    1x17 - 168086
    1x18 - 168087
    1x19 - 168088
    1x20 - 168089
  """
  
  override func viewDidLoad(){
    super.viewDidLoad()
    setupDataSource()
  }
  
  func setupDataSource() {
    dataSource = data.components(separatedBy: "\n")
      .map { (str) -> (String, String) in
      let components = str.components(separatedBy: " - ")
      return (components.first ?? "", components.last ?? "")
    }
  }
}

// MARK: UITableview Datasource Methods
extension MenuViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataSource.count
  }
    
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
    let suffix = indexPath.row % 2 == 0 ? " Bottom" : " Middle"
    cell.textLabel?.text = dataSource[indexPath.row].0 + suffix
    cell.textLabel?.textAlignment = .left
    return cell
  }
}

// MARK: UITableview Delegate Method
extension MenuViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let widgetId = dataSource[indexPath.row].1
    let viewControllerID = indexPath.row % 2 == 0 ?
      "WidgetViewController" :
      "AnotherWidgetViewController"
    guard let viewControllerToPush = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: viewControllerID) as? WidgetViewable else { return }
    viewControllerToPush.widgetId = widgetId
    navigationController?.pushViewController(viewControllerToPush, animated: true)
  }
}



