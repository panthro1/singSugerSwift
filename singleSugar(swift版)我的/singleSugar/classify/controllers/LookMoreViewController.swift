//
//  LookMoreViewController.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

let lookMorecellID = "lookMoreTopicCell"
class LookMoreViewController: BaseViewController {

    var zhauntiModelArr = [zhuantiModel]()
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: String(lookMoreTopicCell), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: lookMorecellID)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = .None
        tableView.rowHeight = 160

        
        loadData()
        
    }

    //加载数据  更多
    func  loadData() {
        let url  =  "v1/collections"
        let params = ["limit": 20,
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
            self!.tableView!.reloadData()
    }
}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension LookMoreViewController:UITableViewDelegate,UITableViewDataSource{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return zhauntiModelArr.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(lookMorecellID) as! lookMoreTopicCell
        cell.zhuanti = zhauntiModelArr[indexPath.row];
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let collectionDetailVC = YMCollectionDetailController()
//        let collection = collections[indexPath.row]
//        collectionDetailVC.title = collection.title
//        collectionDetailVC.id = collection.id
//        collectionDetailVC.type = "专题合集"
//        navigationController?.pushViewController(collectionDetailVC, animated: true)
    }




}