//
//  WKzhuantiCollectionViewCell.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
import Kingfisher
class WKzhuantiCollectionViewCell: UICollectionViewCell {

   
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var plascHoldeBtn: UIButton!
    
    //set方法
    var zhaunti :zhuantiModel? {
        didSet{
        
            let url = zhaunti!.banner_image_url
            backImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.plascHoldeBtn.hidden = true
            
        }
    }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
