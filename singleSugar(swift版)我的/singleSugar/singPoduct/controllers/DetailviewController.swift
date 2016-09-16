//
//  DetailviewController.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/31.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
import SnapKit

class DetailviewController: BaseViewController {

    
    var product :productModel?
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //导航栏分享
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "GiftShare_icon_18x22_"), style: .Plain, target: self, action: #selector(shareBBItemClick))
        
  
          scrollView.contentSize = CGSizeMake(kSCREENW, kSCREENH - 64 - 45 + kMargin + 520)
      //添加轮播图和价格及介绍
        scrollView.addSubview(topScrollView)
        
        topScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.size.equalTo(CGSizeMake(kSCREENW, 520))
        }
        
        //添加底部图文介绍和评论
    scrollView.addSubview(bottomScrollView)
        
        bottomScrollView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(topScrollView.snp_bottom).offset(kMargin)
            make.size.equalTo(CGSizeMake(kSCREENW, kSCREENH - 64 - 45))
        }
    
    }

    
    /// 顶部滚动视图
    private lazy var topScrollView: ProductDetailTopView = {
        let topScrollView = ProductDetailTopView()
        topScrollView.backgroundColor = UIColor.whiteColor()
        topScrollView.product = self.product!
        return topScrollView
    }()
    
    
    /// 底部滚动视图
    private lazy var bottomScrollView: ProductDetailBottomView = {
        let bottomScrollView = ProductDetailBottomView()
        bottomScrollView.backgroundColor = UIColor.whiteColor()
        bottomScrollView.product = self.product!
        return bottomScrollView
    }()

    
    //MARK:分享
    func shareBBItemClick(){
        WKActionSheet.show()
    
    }
    //MARK:去天猫
    @IBAction func gotoTimall(sender: AnyObject) {
    }
   
    //MARK:喜欢
    @IBAction func lickbtnClick(sender: AnyObject) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension DetailviewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var offsetY = scrollView.contentOffset.y
        if offsetY >= 465 {
            offsetY = CGFloat(465)
            scrollView.contentOffset = CGPointMake(0, offsetY)
        }
    }
}

