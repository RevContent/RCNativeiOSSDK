//
//  WidgetCollectionViewCell.swift
//  RCNativeiOSSDKExample
//
//  Created by Mayank Palotra on 15/07/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK

class WidgetCollectionViewCell: UICollectionViewCell
{
    //Instance
    @IBOutlet weak var viewWidget : UIView!
    let widgetID = ["144763","144764","144765","144766"] // Widget ID's array for showing multiple diffrent widget on diffrent sizes.

    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.global(qos: .default).async(execute:
        {
            self.viewWidget.addSubview(self.createWidget(self.widgetID.randomElement()!))
        })
        
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

    
}
