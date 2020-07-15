//
//  WidgetCollectionViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Mayank Palotra on 14/07/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK

class WidgetCollectionViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        RCNativeiOSSDK.setup()
        // Do any additional setup after loading the view.
    }
}
//MARK: UICollectionViewDataSource
extension WidgetCollectionViewController : UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? WidgetCollectionViewCell
        cell!.viewWidget.backgroundColor = .random()
        return cell!
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension WidgetCollectionViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 25
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 5, bottom: 10, right: 5)
        return CGSize(width: 100, height: 100)
    }
}

func createWidget(_ widId : String) -> RCNactiveJSWidgetView
{
    let widget = RCNactiveJSWidgetView.init(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
    // WidgetId is required.
    widget.backgroundColor = .random()
    widget.setWidgetId(widgetId: widId)
    // WidgetSubId is optional.
    widget.setWidgetSubId(widgetSubId:["category":"entertainment", "utm_code":"123456"]);
    // baseUrl is optional.
    widget.setBaseUrl(baseUrl: "https://performance.revcontent.dev")
    //self.view.addSubview(widget)
    widget.loadWidget()
    return widget
}

