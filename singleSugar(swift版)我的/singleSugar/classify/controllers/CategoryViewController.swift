//
//  CategoryViewController.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/26.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class CategoryViewController: BaseViewController ,WKCategoryBottomViewDelegate{


    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //导航栏右边
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Feed_SearchBtn_18x18_"), style: .Plain, target: self, action: #selector(categoryRightBBClick))
        
        
        //设置scrollview
        setupScrollView()
    
    
    }
    func  setupScrollView(){
       
        view.addSubview(scrollview)
    
        //在scrollview上添加 上面专题部分
        // 顶部控制器
        let headerViewController = WKCategoryHeaderViewController()
        addChildViewController(headerViewController)
        
        let topBGView = UIView(frame: CGRectMake(0, 0, kSCREENW, 135))
        scrollview.addSubview(topBGView)
        
        let headerVC = childViewControllers[0]
        topBGView.addSubview(headerVC.view)
        
        
        
        
        //在scrollview上添加  风格品类 部分
        
        //下面风格和品类
        let bottomBGView = WKCategoryBottomView(frame: CGRectMake(0, CGRectGetMaxY(topBGView.frame) + 10, kSCREENW, kSCREENH - 160))
        bottomBGView.backgroundColor = WKGlobalColor()
        bottomBGView.delegate = self
        scrollview.addSubview(bottomBGView)
        scrollview.contentSize = CGSizeMake(kSCREENW, CGRectGetMaxY(bottomBGView.frame))

        
    }

    
    //懒加载一个scrollview
    private lazy  var scrollview :UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollEnabled = true
        scrollView.backgroundColor = WKGlobalColor()
        scrollView.frame = CGRectMake(0, 0, kSCREENW, kSCREENH)
        return scrollView
    }()
    
    
    //导航栏右边点击  搜索界面
    func categoryRightBBClick() {
        let searchBarVC = searchViewController()
        navigationController?.pushViewController(searchBarVC, animated: true)
    }
    
    
    //MARK:WKCategoryBottomViewDelegate
    func bottomViewButtonDidClicked(button: UIButton){
    
        let DetailVC = categoryDetailController()

        DetailVC.title  = button.titleLabel?.text!
        DetailVC.id  = button.tag
        DetailVC.type  = "风格品类"
        navigationController?.pushViewController(DetailVC, animated: true)

    
    }
    
}
