//
//  CollectionViewCell.swift
//  RCNativeiOSSDKExample
//
//  Created by Apple on 23/06/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit
import RCNativeiOSSDK
class CollectionViewCell: UICollectionViewCell {
    var widget: RCNactiveJSWidgetView?{
        didSet{
            guard let widget = widget else { return }
             

                contentView.addSubview(widget)
            }
    }
}


