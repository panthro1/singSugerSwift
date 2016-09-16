//
//  TopicViewController.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/26.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

let homeCellID = "homeCellID"

class TopicViewController: UITableViewController {

    var type = Int()
    
    /// 首页列表数据
    var itemArr = [HomeItemModel]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = WKGlobalColor()
        
        // 添加控件tableview
        setupTableView()
        
        //加载数据
        loadHomeData()
        
        // 添加刷新控件
        refreshControl = RefreshControl()
        refreshControl?.beginRefreshing()
        refreshControl?.addTarget(self, action: #selector(loadHomeData), forControlEvents: .ValueChanged)

        
    }
    
    func loadHomeData() {
        //请求首页主要数据
        let url  = "v1/channels/\(type)/items"
        
        let params = ["gender": 1,
                      "generation": 1,
                      "limit": 20,
                      "offset": 0]
        NetworkTools.shareNetworkTool.loadGETRequestDataInfo(url,params: params) { [weak self] (dataDict) in
            print(dataDict)
            if let items = dataDict["items"]?.arrayObject {
                for item in items {
                    let homeItem = HomeItemModel(dict: item as! [String: AnyObject])
                    self!.itemArr.append(homeItem)
                }
            }
            //刷新
            self!.tableView!.reloadData()
            self!.refreshControl?.endRefreshing()
            
            
        }

    }

    
    func setupTableView() {
        tableView.rowHeight = 160
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewY + kTitlesViewH, 0, tabBarController!.tabBar.height, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        let nib = UINib(nibName: String(WKHomeCell), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: homeCellID)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
}


 extension TopicViewController : WKHomeCellDelegate{
// MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count ?? 0
    }
 
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let homeCell = tableView.dequeueReusableCellWithIdentifier(homeCellID) as! WKHomeCell
        homeCell.selectionStyle = .None
        homeCell.homeItemModel = itemArr[indexPath.row]
        homeCell.delegate = self
        return homeCell
    }
    // MARK: - UITableViewDelegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = detailViewController()
        let homeModel = itemArr[indexPath.row]
        detailVC.Str = homeModel.content_url!
        detailVC.title = "攻略详情"
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - YMHomeCellDelegate
    func homeCellDidClickedFavoriteButton(button: UIButton) {
        if !NSUserDefaults.standardUserDefaults().boolForKey(isLogin) {
//            let loginVC = YMLoginViewController()
//            loginVC.title = "登录"
//            let nav = YMNavigationController(rootViewController: loginVC)
//            presentViewController(nav, animated: true, completion: nil)
//        } else {
//            
//        }
    }

    }

}
