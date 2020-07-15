//
//  WidgetCollectionViewCell.swift
//  RCNativeiOSSDKExample
//
//  Created by Mayank Palotra on 15/07/20.
//  Copyright © 2020 Revcontent. All rights reserved.
//

import UIKit

class WidgetCollectionViewCell: UICollectionViewCell
{
    //Instance
    @IBOutlet weak var viewWidget : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        DispatchQueue.main.async
        {
            self.addSubview(createWidget("66620"))
        }
    }

}
