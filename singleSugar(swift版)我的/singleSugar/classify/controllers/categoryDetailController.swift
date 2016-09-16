//
//  categoryDetailController.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
 let categoryDetailCellID = "categoryDetailCell"
class categoryDetailController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var type = String()
    
    var groupCollcetModelArr = [groupCollcetModel]()
    
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      let nib = UINib(nibName: String(categoryDetailCell), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: categoryDetailCellID)
        tableView.rowHeight = 150
        tableView.separatorStyle = .None
        

    if type == "专题合集" {  //专题集合
    
    let url  = "v1/collections/\(id!)/posts"
    let params = ["gender": 1,
    "generation": 1,
    "limit": 20,
    "offset": 0]
    
    NetworkTools.shareNetworkTool.loadGETRequestDataInfo(url,params: params) { [weak self] (dataDict) in
    print(dataDict)
       if let items = dataDict["posts"]?.arrayObject {
    for item in items {
        let groupCollcetmodel = groupCollcetModel(dict: item as! [String: AnyObject])
    self!.groupCollcetModelArr.append(groupCollcetmodel)
      }
    }
       //刷新
       self!.tableView!.reloadData()
    }

    } else if type == "风格品类" {

        let url =  "v1/channels/\(id!)/items"
        let params = ["limit": 20,
                      "offset": 0]
        NetworkTools.shareNetworkTool.loadGETRequestDataInfo(url,params: params) { [weak self] (dataDict) in
            print(dataDict)
            if let items = dataDict["items"]?.arrayObject {
                for item in items {
                    let groupCollcetmodel = groupCollcetModel(dict: item as! [String: AnyObject])
                    self!.groupCollcetModelArr.append(groupCollcetmodel)
                }
            }
            //刷新
            self!.tableView!.reloadData()
        }

 
    }
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}


extension categoryDetailController:UITableViewDataSource,UITableViewDelegate{

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupCollcetModelArr.count ?? 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(categoryDetailCellID) as! categoryDetailCell
      
        cell.groupCollcetmodel = groupCollcetModelArr[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //详情
        
        
    }
}
