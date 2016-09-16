//
//  lookMoreTopicCell.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class lookMoreTopicCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var placeholderButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subtitleLabel: UILabel!

    var zhuanti: zhuantiModel? {
        didSet {
            let url = zhuanti!.cover_image_url
            bgImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil) { (image, error, cacheType, imageURL) in
                self.placeholderButton.hidden = true
            }
            titleLabel.text = zhuanti!.title
            subtitleLabel.text = zhuanti!.subtitle
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        bgImageView.layer.cornerRadius = kCornerRadius
        bgImageView.layer.masksToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
