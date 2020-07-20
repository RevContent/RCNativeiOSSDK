//
//  WidgetCollectionViewController.swift
//  RCNativeiOSSDKExample
//
//  Created by Mayank Palotra on 14/07/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK
import WebKit

class WidgetCollectionViewController: UIViewController
{
    // Instance of WidgetCollectionViewController
    let widgetID = ["144703","144704","144705","144706","144707","144708","144709","144710", "144711","144712","144713","144750","144751","144752","144754","144755","144756","144757", "144758","144760","144761","144763","144764","144765","144766"] // Widget ID's array for showing multiple diffrent widget on diffrent sizes.
    
    //@IBOutlet weak var viewWidget : UIView!
    let widgetIDGallery = ["144763","144764","144765","144766"] // Widget ID's array for showing multiple diffrent widget on diffrent sizes.

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        RCNativeiOSSDK.setup()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        // Get All Cookies list of visited widets.
        if #available(iOS 11, *) {
            let dataStore = WKWebsiteDataStore.default()
            dataStore.httpCookieStore.getAllCookies({ (cookies) in
                print(cookies)
                
                for cookie in cookies {
                    var cookieProperties = [HTTPCookiePropertyKey: Any]()
                    cookieProperties[.name] = cookie.name
                    cookieProperties[.value] = cookie.value
                    cookieProperties[.domain] = cookie.domain
                    cookieProperties[.path] = cookie.path
                    cookieProperties[.version] = cookie.version
                    cookieProperties[.expires] = Date().addingTimeInterval(31536000)
                    
                    let newCookie = HTTPCookie(properties: cookieProperties)
                    HTTPCookieStorage.shared.setCookie(newCookie!)
                    print(newCookie!)
                    print("name: \(cookie.name) value: \(cookie.value)")
                }
            })
        } else {
            guard let cookies = HTTPCookieStorage.shared.cookies else {
                return
            }
            print(cookies)
        }
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


