//
//  WKCategoryBottomView.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
import Kingfisher

protocol WKCategoryBottomViewDelegate: NSObjectProtocol {
    func bottomViewButtonDidClicked(button: UIButton)
}

class WKCategoryBottomView: UIView {

    
     weak var delegate: WKCategoryBottomViewDelegate?
    
     var outGroupArr = [AnyObject]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //请求数据
        loadData()
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:请求数据
    func loadData(){

        let url = "v1/channel_groups/all"
        NetworkTools.shareNetworkTool.loadGETRequestDataInfoWithOutParmas(url) { (dataDict) in
            if let channel_groups = dataDict["channel_groups"]?.arrayObject{
                for  channel_group in channel_groups{
                    
                     var inGroups = [groudModel]()
                    
                    let channels = channel_group["channels"] as! [AnyObject]
                    for channel in channels{
                       let group = groudModel(dict: channel as! [String: AnyObject])
                        inGroups.append(group)
                    }
                    self.outGroupArr.append(inGroups)
                    
                }
            }
            //刷新
            self.setupUI()
        }
        }
    
    //布局ui
    private func setupUI() {
    
        let topGroups = outGroupArr[0] as! NSArray
        let bottomGroups = outGroupArr[1] as! NSArray
        
        //风格
        let topView = UIView()
        topView.width = kSCREENW
        topView.backgroundColor = UIColor.whiteColor()
        addSubview(topView)
        
        let styleLabel = setupLabel("风格")
        topView.addSubview(styleLabel)
    
        
        
        for index in 0..<topGroups.count {
            let group = topGroups[index] as! groudModel
            let button = setupButton(index, group: group)
            topView.addSubview(button)
            if index == topGroups.count - 1 {
                topView.height = CGRectGetMaxY(button.frame) + kMargin
            }
        }
        
        // 品类
        let bottomView = UIView()
        bottomView.width = kSCREENW
        bottomView.y = CGRectGetMaxY(topView.frame) + kMargin
        bottomView.backgroundColor = UIColor.whiteColor()
        addSubview(bottomView)
        let categoryLabel = setupLabel("品类")
        bottomView.addSubview(categoryLabel)
        
        for index in 0..<bottomGroups.count {
            let grou = bottomGroups[index] as! groudModel
            let button = setupButton(index, group: grou)
            bottomView.addSubview(button)
            if index == bottomGroups.count - 1 {
                bottomView.height = CGRectGetMaxY(button.frame) + kMargin
            }
        }

    
    }
    
    private func setupButton(index: Int, group: groudModel) -> WKVerticalButton{
        let buttonW: CGFloat = kSCREENW / 4
        let buttonH: CGFloat = buttonW
        let styleLabelH: CGFloat = 40
        
        let button = WKVerticalButton()
        button.width = buttonW
        button.height = buttonH
        button.x = buttonW * CGFloat(index % 4)
        button.y = buttonH * CGFloat(index / 4) + styleLabelH
        if index > 3 {
            button.y = buttonH * CGFloat(index / 4) + styleLabelH + kMargin
        }
        button.tag = group.id!
        button.addTarget(self, action: #selector(groupButonClick(_:)), forControlEvents: .TouchUpInside)
        button.titleLabel?.font = UIFont.systemFontOfSize(15)
        button.setTitleColor(WKColor(0, g: 0, b: 0, a: 0.6), forState: .Normal)
        button.kf_setImageWithURL(NSURL(string: group.icon_url!)!, forState: .Normal)
        button.setTitle(group.name, forState: .Normal)
        return button
    }
    
    func groupButonClick(button: UIButton) {
        delegate?.bottomViewButtonDidClicked(button)
    }

    private func setupLabel(title: String) -> UILabel {
        let styleLabel = UILabel(frame: CGRectMake(10, 0, kSCREENW - 10, 40))
        styleLabel.text = title
        styleLabel.textColor = WKColor(0, g: 0, b: 0, a: 0.6)
        styleLabel.font = UIFont.systemFontOfSize(16)
        return styleLabel
    }


}
