//
//  WKActionSheet.swift
//  singleSugar
//
//  Created by 汪凯 on 16/9/1.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
import SnapKit
class WKActionSheet: UIView {

    class func show() {   //类方法
        let actionSheet = WKActionSheet()
        actionSheet.frame = UIScreen.mainScreen().bounds
        actionSheet.backgroundColor = WKColor(0, g: 0, b: 0, a: 0.6)
        
        let window = UIApplication.sharedApplication().keyWindow
        window?.addSubview(actionSheet)
    }

    //布局ui  让bgView 从下面升上来
    override func layoutSubviews() {
        super.layoutSubviews()
        UIView.animateWithDuration(kAnimationDuration) {
            self.bgView.y = kSCREENH - self.bgView.height
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:设置ui
    func setupUI() {
      //添加分享框 底层
          addSubview(bgView)
        
        // 上部 分享界面
        bgView.addSubview(topView)
        // 下部取消按钮
        bgView.addSubview(cancelButton)
        // 分享到 标签
        topView.addSubview(shareLabel)
        // 6 个分享按钮的 view
        topView.addSubview(shareButtonView)
        
        topView.snp_makeConstraints { (make) in
            make.bottom.equalTo(cancelButton.snp_top).offset(-kMargin)
            make.left.equalTo(cancelButton.snp_left)
            make.right.equalTo(cancelButton.snp_right)
            make.height.equalTo(kTopViewH)
        }
        
        cancelButton.snp_makeConstraints { (make) in
            make.left.equalTo(bgView).offset(kMargin)
            make.right.bottom.equalTo(bgView).offset(-kMargin)
            make.height.equalTo(44)
        }
        
        shareLabel.snp_makeConstraints { (make) in
            make.left.right.top.equalTo(topView)
            make.height.equalTo(30)
        }
    
    }
    
   
    //MARK:懒加载bgView
    private lazy var bgView : UIView = {
        let bgView = UIView()
        bgView.frame = CGRectMake(0, kSCREENH, kSCREENW, 280)
        return bgView
    
    }()
    //MARK:懒加载topView
    private lazy var topView:UIView = {
      let topView = UIView()
        topView.backgroundColor = UIColor.whiteColor()
        topView.layer.cornerRadius = kCornerRadius
        topView.layer.masksToBounds = true
    return topView
    }()
    
     //MARK:懒加载cancelButton
    private lazy var cancelButton: UIButton = {
        let cancelButton = UIButton()
        cancelButton.setTitle("取消", forState: .Normal)
        cancelButton.titleLabel?.font = UIFont.systemFontOfSize(18)
        cancelButton.setTitleColor(WKColor(37, g: 142, b: 240, a: 1.0), forState: .Normal)
        cancelButton.backgroundColor = UIColor.whiteColor()
        cancelButton.addTarget(self, action: #selector(cancelButtonClick), forControlEvents: .TouchUpInside)
        cancelButton.layer.cornerRadius = kCornerRadius
        cancelButton.layer.masksToBounds = true
        return cancelButton
    }()
    
    
    //MARK:取消按钮点击
    func cancelButtonClick(){
        UIView.animateWithDuration(kAnimationDuration, animations: {
            self.bgView.y = kSCREENH
        }) { (_) in
            self.removeFromSuperview()
        }

    
    }
    
    
    // 分享到标签
    private lazy var shareLabel: UILabel = {
        let shareLabel = UILabel()
        shareLabel.text = "分享到"
        shareLabel.textColor = WKColor(0, g: 0, b: 0, a: 0.7)
        shareLabel.textAlignment = .Center
        return shareLabel
    }()
    
    // 6个按钮
    private lazy var shareButtonView: WKShareButtonView = {
        let shareButtonView = WKShareButtonView()
        shareButtonView.frame = CGRectMake(0, 30, kSCREENW - 20, kTopViewH - 30)
        return shareButtonView
    }()

    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        UIView.animateWithDuration(kAnimationDuration, animations: {
            self.bgView.y = kSCREENH
        }) { (_) in
            self.removeFromSuperview()
        }
    }

    
}
