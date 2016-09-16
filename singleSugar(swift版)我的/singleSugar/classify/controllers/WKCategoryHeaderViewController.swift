//
//  WKCategoryHeaderViewController.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
let WKzhuantiCollectionViewCellID = "WKzhuantiCollectionViewCell"
class WKCategoryHeaderViewController: BaseViewController {

    
    var zhauntiModelArr = [zhuantiModel]()
  weak var collectionView = UICollectionView?()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //添加专题合计lable  和查看更多按钮
        setLabelAndButton()
        
        setCollectionView()
        
        //加载数据
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    
    func loadData(){
    
        let url  =  "v1/collections"
        
        let params = ["limit": 6,
                      "offset": 0]
        NetworkTools.shareNetworkTool.loadGETRequestDataInfo(url,params: params) { [weak self] (dataDict) in
            print(dataDict)
            if let items = dataDict["collections"]?.arrayObject {
                for item in items {
                    let productmodel = zhuantiModel(dict: item as! [String: AnyObject])
                    self!.zhauntiModelArr.append(productmodel)
                }
            }
            //刷新
            self!.collectionView!.reloadData()
        }
    }
    
    //添加专题合计lable  和查看更多按钮
    func  setLabelAndButton(){
        
        let titleView = UIView()
        titleView.frame = CGRectMake(0, 0, kSCREENW, 36)
        titleView.backgroundColor = UIColor.whiteColor()
        view.addSubview(titleView)
        
     let  label = UILabel()
        label.frame = CGRectMake(10, 5, 100, 30)
        label.text = "专题合集"
        label.textColor = UIColor.lightGrayColor()
        label.font = UIFont.systemFontOfSize(15)
        titleView.addSubview(label)
        
        
        let bnt = UIButton()
        bnt.frame = CGRectMake(kSCREENW-80, 5, 80, 30)
        bnt.setTitle("查看全部>", forState: UIControlState.Normal)
        bnt.titleLabel?.font  = UIFont.systemFontOfSize(13)
        bnt.addTarget(self, action: #selector(lookMore), forControlEvents: UIControlEvents.TouchUpInside)
        bnt.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        titleView.addSubview(bnt)
    }
    
   func setCollectionView(){
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .Horizontal
    let collectionView = UICollectionView(frame: CGRectMake(0, 36, kSCREENW, 95), collectionViewLayout: flowLayout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = UIColor.whiteColor()
    let cellNib = UINib(nibName: String(WKzhuantiCollectionViewCell), bundle: nil)
    collectionView.registerNib(cellNib, forCellWithReuseIdentifier: WKzhuantiCollectionViewCellID)
    view.addSubview(collectionView)
    self.collectionView = collectionView

    }
    
    //查看更多
    func lookMore(){
      let lookVC =   LookMoreViewController()
      lookVC.title = "查看全部"
        navigationController?.pushViewController(lookVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension WKCategoryHeaderViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return zhauntiModelArr.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(WKzhuantiCollectionViewCellID, forIndexPath: indexPath) as! WKzhuantiCollectionViewCell
        cell.zhaunti = zhauntiModelArr[indexPath.item]
        return cell
}
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let DetailVC = categoryDetailController()
        
        let zhaunti = zhauntiModelArr[indexPath.item]
        
        DetailVC.title  = zhaunti.title
        DetailVC.id  = zhaunti.id
        DetailVC.type  = "专题合集"
        navigationController?.pushViewController(DetailVC, animated: true)
    }

    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(kitemW, kitemH)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin)
    }

    
    
}