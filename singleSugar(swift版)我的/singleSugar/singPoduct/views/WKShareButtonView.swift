//
//  WKShareButtonView.swift
//  singleSugar
//
//  Created by 汪凯 on 16/9/1.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class WKShareButtonView: UIView {

    // 图片数组
    let images = ["Share_WeChatTimelineIcon_70x70_", "Share_WeChatSessionIcon_70x70_", "Share_WeiboIcon_70x70_", "Share_QzoneIcon_70x70_", "Share_QQIcon_70x70_", "Share_CopyLinkIcon_70x70_"]
    // 标题数组
    let titles = ["微信朋友圈", "微信好友", "微博", "QQ 空间", "QQ 好友", "复制链接"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        let maxCols = 3
        
        let buttonW: CGFloat = 70
        let buttonH: CGFloat = buttonW + 30
        let buttonStartX: CGFloat = 20
        let xMargin: CGFloat = (kSCREENW - 20 - 2 * buttonStartX - CGFloat(maxCols) * buttonW) / CGFloat(maxCols - 1)
        
        // 创建按钮
        for index in 0..<images.count {
            let button = WKVerticalButton()
            button.tag = index
            button.setImage(UIImage(named: images[index]), forState: .Normal)
            button.setTitle(titles[index], forState: .Normal)
            button.setTitleColor(UIColor.blackColor(), forState: .Normal)
            button.titleLabel?.font = UIFont.systemFontOfSize(14)
            button.width = buttonW
            button.height = buttonH
            button.addTarget(self, action: #selector(shareButtonClick(_:)), forControlEvents: .TouchUpInside)
            
            // 计算 X、Y
            let row = Int(index / maxCols)
            let col = index % maxCols
            let buttonX: CGFloat = CGFloat(col) * (xMargin + buttonW) + buttonStartX
            let buttonMaxY: CGFloat = CGFloat(row) * buttonH
            let buttonY = buttonMaxY
            button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH)
            addSubview(button)
        }
    }
    
    func shareButtonClick(button: UIButton) {
        if let shareButtonType = WKShareButtonType(rawValue: button.tag) {
            switch shareButtonType {
            case .WeChatTimeline:
                
                break
            case .WeChatSession:
                
                break
            case .Weibo:
                
                break
            case .QZone:
                
                break
            case .QQFriends:
                
                break
            case .CopyLink:
                
                break
            }
        }
//        print(button.titleLabel!.text!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
