//
//  YMCommentCell.swift
//  DanTang
//
//  Created by 杨蒙 on 16/7/27.
//  Copyright © 2016年 hrscy. All rights reserved.
//

import UIKit
import Kingfisher

class YMCommentCell: UITableViewCell {

    var comment: WKComment? {
        didSet {
            let user = comment!.user
            let url = user!.avatar_url
            avatarImageView.kf_setImageWithURL(NSURL(string: url!)!, placeholderImage: nil, optionsInfo: nil
                , progressBlock: nil) { (image, error, cacheType, imageURL) in
                    //
            }
            nicknameLabel.text = user!.nickname
            contentLabel.text = comment!.content

            let str = "\(comment!.created_at!)"
            
            let timeStr =  timeStampToString(str)
            
            timeLabel.text = timeStr
        }
    }
    
     func timeStampToString(timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:NSTimeInterval = string.doubleValue
        let dfmatter = NSDateFormatter()
        dfmatter.dateFormat="M-dd HH:mm"
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        return dfmatter.stringFromDate(date)
    }
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nicknameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
