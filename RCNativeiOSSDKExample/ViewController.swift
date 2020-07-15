//
//  ViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Apple on 21/05/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import UIKit
import RCNativeiOSSDK

class ViewController: UIViewController
{
    // Instance
    var tableData = ["Example Full Screen", "Example 1/3 Of Screen", "Example 1/8 Of Screen", "Example 100 widget of 1x1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

// MARK: UITableview Datasource Methods
extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tableData[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
}

// MARK: UITableview Delegate Method
extension ViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 0
        {
            let vc = storyboard?.instantiateViewController(identifier: "ShowWidgetViewController") as? ShowWidgetViewController
            vc!.widgetCount = 1
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 1
        {
            let vc = storyboard?.instantiateViewController(identifier: "ShowWidgetViewController") as? ShowWidgetViewController
            vc!.widgetCount = 3
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 2
        {
            let vc = storyboard?.instantiateViewController(identifier: "ShowWidgetViewController") as? ShowWidgetViewController
            vc!.widgetCount = 8
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if indexPath.row == 3
        {
            let vc = storyboard?.instantiateViewController(identifier: "WidgetCollectionViewController") as? WidgetCollectionViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
}



