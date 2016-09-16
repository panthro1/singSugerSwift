//
//  searchVC.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/26.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
let searchCollectionCellID = "searchCollectionCellID"
class searchViewController: BaseViewController {

    /// 数组
    var resulArr = [searchResulModel]()
    /// collectionView
    weak var collectionView: UICollectionView?
    
    ///懒加载searchBar
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索商品、专题"
        return searchBar
    }()
    
    /// 懒加载searchRecordView
    private lazy var searchRecordView: SearchRecordView = {
        let searchRecordView = SearchRecordView()
        searchRecordView.backgroundColor = WKGlobalColor()
        searchRecordView.frame = CGRectMake(0, 64, kSCREENW, kSCREENH - 64)
        return searchRecordView
    }()


    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.resignFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航栏
        setupNav()
        
        //添加搜索记录 view
         view.addSubview(searchRecordView)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 设置导航栏
   func setupNav(){
    navigationItem.titleView = searchBar
    searchBar.delegate = self
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .Plain, target: self, action: #selector(navigationBackClick))
    
    }

    /**
     取消按钮  返回
     */
    func navigationBackClick() {
        navigationController?.popViewControllerAnimated(true)
    }

    
    /// 搜索条件点击
    func sortButtonClick() {
        popView.show()
    }
    
    private lazy var popView: SortTableView = {
        let popView = SortTableView()
        popView.delegate = self
        return popView
    }()

    
    
    /// 设置collectionView
    private func setupCollectionView() {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        collectionView.backgroundColor = view.backgroundColor
        collectionView.dataSource = self
        let nib = UINib(nibName: String(WKCollectionViewCell), bundle: nil)
        collectionView.registerNib(nib, forCellWithReuseIdentifier: searchCollectionCellID)
        view.addSubview(collectionView)
        self.collectionView = collectionView
    }

    
}



//YMCollectionViewCellDelegate.YMSortTableViewDelegate
extension searchViewController: UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource,  UICollectionViewDelegateFlowLayout,SortTableViewDelegate,WKCollectionViewCellDelegate{
    // 一点击搜索结束   就添加CollectionView
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        /// 设置collectionView
        setupCollectionView()
        return true
    }
    
    
    /// 搜索按钮点击
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .Plain, target: self, action: #selector(navigationBackClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "icon_sort_21x21_"), style: .Plain, target: self, action: #selector(sortButtonClick))
        /// 根据搜索条件进行搜索
        let keyword = searchBar.text
        
        let url = "http://api.dantangapp.com/v1/search/item"
        
        let params = ["keyword": keyword!,
                      "limit": 20,
                      "offset": 0,
                      "sort": ""]
       NetworkTools.shareNetworkTool.loadGETRequestDataInfo(url, params: params as! [String : AnyObject]) { (dataDict) in
        if let items = dataDict["items"]?.arrayObject {
            for item in items {
                let result = searchResulModel(dict: item as! [String: AnyObject])
                self.resulArr.append(result)
            }
        }
        self.collectionView!.reloadData()
        }
    }
    
        
        
        // MARK: - UICollectionViewDataSource
        func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return resulArr.count ?? 0
        }
        

        
        func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(searchCollectionCellID, forIndexPath: indexPath) as! WKCollectionViewCell
            cell.result = resulArr[indexPath.item]
            cell.delegate = self
            return cell
        }
        
        // MARK: - UICollectionViewDelegate
        func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//            let productDetailVC = YMProductDetailViewController()
//            productDetailVC.title = "商品详情"
//            productDetailVC.type = String(self)
//            productDetailVC.result = results[indexPath.item]
//            navigationController?.pushViewController(productDetailVC, animated: true)
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
//            if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
//                let loginVC = YMLoginViewController()
//                loginVC.title = "登录"
//                let nav = YMNavigationController(rootViewController: loginVC)
//                presentViewController(nav, animated: true, completion: nil)
//            } else {
//                
//            }
        }
        
        // MARK: - YMSortTableViewDelegate
        func sortView(sortView: SortTableView, didSelectSortAtIndexPath sort: String) {
            /// 根据搜索条件进行搜索
            let keyword = searchBar.text
            
            let url = "http://api.dantangapp.com/v1/search/item"
            
            let params = ["keyword": keyword!,
                          "limit": 20,
                          "offset": 0,
                          "sort": sort]
            NetworkTools.shareNetworkTool.loadGETRequestDataInfo(url, params: params as! [String : AnyObject]) { (dataDict) in
                if let items = dataDict["items"]?.arrayObject {
                    for item in items {
                        let result = searchResulModel(dict: item as! [String: AnyObject])
                        self.resulArr.append(result)
                    }
                }
                  self.collectionView!.reloadData()
        }

  
        
    }




}
