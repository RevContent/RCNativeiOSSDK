//
//  MenuViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Apple on 15/09/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK

class MenuViewController: UIViewController
{
    // Instance
    var tableData = ["1x6 Bottom", "1x7 Bottom",  "1x8 Bottom", "1/9 Bottom", "1/10 Bottom", "1x6 Middle", "1x7 Middle",  "1x8 Middle", "1/9 Middle", "1/10 Middle"]
    let widgetID = ["144708","144710","144711","144712","144713","144708","144710","144711","144712","144713"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: UITableview Datasource Methods
extension MenuViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tableData[indexPath.row]
        cell.textLabel?.textAlignment = .left
        return cell
    }
}

// MARK: UITableview Delegate Method
extension MenuViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let widgetId = widgetID[indexPath.row]
        if indexPath.row < 5
        {
            let vc = storyboard?.instantiateViewController(identifier: "WidgetViewController") as? WidgetViewController
            vc!.widgetId = widgetId
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else
        {
            let vc = storyboard?.instantiateViewController(identifier: "AnotherWidgetViewController") as? AnotherWidgetViewController
            vc!.widgetId = widgetId
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}



