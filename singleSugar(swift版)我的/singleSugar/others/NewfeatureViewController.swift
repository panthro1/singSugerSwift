//
//  NewfeatureViewController.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/26.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
import SnapKit
let newFeatureID = "newFeatureID"
class NewfeatureViewController: UICollectionViewController {
   
    //声明的全局变量
    var  layout :UICollectionViewLayout  =  NewfeatureLayout() //自定义的一个UICollectionViewLayout类
    
    init() {
        super.init(collectionViewLayout: layout)
        collectionView?.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.registerClass(NewfeatureCell.self, forCellWithReuseIdentifier: newFeatureID)
        
    }
 
}
//MARK:collectionView delegate
extension NewfeatureViewController{

    //numberOfItemsInSection
   override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //
      return kNewFeatureCount
    }
    
    //cellForItemAtIndexPath
   override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(newFeatureID, forIndexPath: indexPath) as!NewfeatureCell

    cell.imageIndex = indexPath.item
    return cell
    }
    //didEndDisplayingCell  主要来处理 最后一个cell 出现
   override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    //最后一个cell
        let path = collectionView.indexPathsForVisibleItems().last!
    if path.item==(kNewFeatureCount-1) {
        let cell = collectionView.cellForItemAtIndexPath(path) as! NewfeatureCell
        //调用动画
        cell.startBtnAnimation()
    }
    }


}

private class NewfeatureCell :UICollectionViewCell{
    //定义一个iconView
    private lazy var iconView = UIImageView()
    //懒加载一个button
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "btn_begin"), forState: .Normal)
        btn.addTarget(self, action: #selector(startButtonClick), forControlEvents: .TouchUpInside)
        btn.layer.masksToBounds = true
        btn.hidden = true  //按钮默认是隐藏的
        return btn
    }()
    
    @objc func startButtonClick() {
        UIApplication.sharedApplication().keyWindow?.rootViewController = baseTabBarController()
    }

    //初始化 界面
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   //布局ui
    func setupUI(){
        //添加按钮和图片
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        //约束按钮和图片
        iconView.snp_makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        startButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp_bottom).offset(-50)
            make.size.equalTo(CGSizeMake(150, 40))
            make.centerX.equalTo(0)
        }
    }
    
    
     //重写imageInde的set方法
    private var imageIndex :Int?{
        didSet {
         iconView.image = UIImage(named: "walkthrough_\(imageIndex! + 1)")
        
        }
        
    }

//最后一个cell  出现的动画
    func startBtnAnimation() {
        //显示开始按钮
        startButton.hidden = false
        // 执行动画
        startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        startButton.userInteractionEnabled = false
        
        // UIViewAnimationOptions(rawValue: 0) == OC knilOptions
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            // 清空形变
            self.startButton.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                self.startButton.userInteractionEnabled = true
        })
    }


}

// MARK :自定义的一个UICollectionViewFlowLayout类
 private  class NewfeatureLayout: UICollectionViewFlowLayout {
 
    private override  func prepareLayout() {
        // 设置 layout 布局
        itemSize = UIScreen.mainScreen().bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        // 设置 contentView 属性
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
        
    }
}

