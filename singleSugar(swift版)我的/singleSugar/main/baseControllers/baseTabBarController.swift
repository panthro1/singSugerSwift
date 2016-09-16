//
//  baseTabBarController.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/26.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class baseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor(red: 245 / 255, green: 80 / 255, blue: 83 / 255, alpha: 1.0)
        // 添加子控制器
        addChildViewControllers()
    }
    
    
    //添加子控制器
  private  func addChildViewControllers() {
        
        addChildViewController("singSugarViewController", title: "单糖", imageName: "TabBar_home_23x23_")
        addChildViewController("singPoductViewController", title: "单品", imageName: "TabBar_gift_23x23_")
        addChildViewController("CategoryViewController", title: "分类", imageName: "TabBar_category_23x23_")
        addChildViewController("MeViewController", title: "我", imageName: "TabBar_me_boy_23x23_")
    }
    
    /**
     # 初始化子控制器
     
     - parameter childControllerName: 需要初始化的控制器
     - parameter title:               标题
     - parameter imageName:           图片名称
     */
    private func addChildViewController(childControllerName:String,title:String,imageName:String){
        /*
         swift中新增了一个叫做命名空间的概念()
         不同项目中的命名空间是不一样的,默认情况下命名空间的名称就是当前项目的名称
         正式因为swift可以通过命名空间来解决重名的问题,所以在swift开发中尽量是用cocoapods来集成第三方框架,这样可以有效的避免类名重复
         正是因为swift中命名空间,所以通过一个字符创建一个类和OC中不一样,oc中可以直接通过类名创建一个类,而swift中如果要通过类名来创建一个类必须要加上命名空间
         */
        // 动态获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        // 将字符串转化为类，默认情况下命名空间就是项目名称，但是命名空间可以修改
        let cls: AnyClass? = NSClassFromString(ns + "." + childControllerName)
        let vcClass = cls as! UIViewController.Type
        let vc = vcClass.init()
        // 设置对应的数据
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        vc.title = title
        // 给每个控制器包装一个导航控制器
        let nav = baseNavigationController()
        nav.addChildViewController(vc)
        addChildViewController(nav)
        
    
    
    }
    
    
}
