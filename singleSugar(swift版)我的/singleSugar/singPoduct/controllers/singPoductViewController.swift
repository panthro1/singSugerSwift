//
//  singPoductViewController.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/26.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
let collectionCellID = "WKCollectionViewCell"
class singPoductViewController: BaseViewController {
    /// 单品数据
    var productArr = [productModel]()

    weak var collectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         view.backgroundColor = WKGlobalColor()
        
        // 添加控件CollectionView
        setupCollectionView()
        
        
        //加载数据
        loadSingPoductData()
        
        
        //添加刷新空间
//        myRefreshControl = RefreshControl()
//        myRefreshControl?.beginRefreshing()
//        myRefreshControl?.addTarget(self, action: #selector(loadSingPoductData), forControlEvents: .ValueChanged)
        
}
    
    //MARK:设置CollectionView
 private  func setupCollectionView(){
    
    let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView.backgroundColor = view.backgroundColor
    collectionView.delegate = self
    collectionView.dataSource = self
    let nib = UINib(nibName: String(WKCollectionViewCell), bundle: nil)
    collectionView.registerNib(nib, forCellWithReuseIdentifier: collectionCellID)
    view.addSubview(collectionView)
    self.collectionView = collectionView
    
    
    }
    //MARK:加载数据
 private  func loadSingPoductData(){
    //请求首页主要数据
    let url  = "v2/items"
    
    let params = ["gender": 1,
    "generation": 1,
    "limit": 20,
    "offset": 0]
    NetworkTools.shareNetworkTool.loadGETRequestDataInfo(url,params: params) { [weak self] (dataDict) in
    print(dataDict)
    if let items = dataDict["items"]?.arrayObject {
          for item in items {
            let itemData = item["data"]
               let productmodel = productModel(dict: itemData as! [String: AnyObject])
               self!.productArr.append(productmodel)
                }
           }
        //刷新
        self!.collectionView!.reloadData()
//         self!.myRefreshControl?.endRefreshing()
      }
   
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}

extension singPoductViewController: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WKCollectionViewCellDelegate{
       // MARK: - UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return productArr.count ?? 0
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let  cell = collectionView .dequeueReusableCellWithReuseIdentifier(collectionCellID, forIndexPath: indexPath) as! WKCollectionViewCell
        cell.product = productArr[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let productDetailVC = DetailviewController()
        productDetailVC.title = "商品详情"
        productDetailVC.product = productArr[indexPath.item]
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
    
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width: CGFloat = (UIScreen.mainScreen().bounds.width - 20) / 2
        let height: CGFloat = 245
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }

    
    // MARK: - YMCollectionViewCellDelegate
    func collectionViewCellDidClickedLikeButton(button: UIButton) {
        //如果没哟登录过 就先登录
//        if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
//            let loginVC = YMLoginViewController()
//            loginVC.title = "登录"
//            let nav = YMNavigationController(rootViewController: loginVC)
//            presentViewController(nav, animated: true, completion: nil)
//        } else {
//            
//        }
    }



}
