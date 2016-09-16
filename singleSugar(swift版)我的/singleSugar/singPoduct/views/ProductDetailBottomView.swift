//
//  ProductDetailBottomView.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/31.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
import SnapKit

let commentCellID = "commentCellID"
class ProductDetailBottomView: UIView {

 
    var comments = [WKComment]()
    
    var product: productModel? {
        didSet {
            /// 获取单品详细数据
            let url = "v2/items/\(product!.id!)"
            
             NetworkTools.shareNetworkTool.loadGETRequestDataInfoWithOutParmasWithAnyObject(url) {[weak self] (dataDict) in
                let productDetail = ProductDetailModel(dict: dataDict)

                self!.choiceButtonView.commentButton.setTitle("评论(\(productDetail.comments_count!))", forState: .Normal)
            self!.webView.loadHTMLString(productDetail.detail_html!, baseURL: nil)

            }
            /// 获取评论数据
            let urlstr = "v2/items/\(product!.id!)/comments"
            NetworkTools.shareNetworkTool.loadGETRequestDataInfoWithOutParmas(urlstr) {[weak self] (dataDict) in
                if let commentsData = dataDict["comments"]?.arrayObject {
                    for item in commentsData {
                    let comment = WKComment(dict: item as! [String: AnyObject])
                        self!.comments.append(comment)
                      }
                   }
                 self!.tableView.reloadData()
               }

    }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        // 添加顶部选择按钮 view（图文介绍，评论）
        addSubview(choiceButtonView)
        
        addSubview(tableView)
        
        addSubview(webView)
        
        choiceButtonView.snp_makeConstraints { (make) in
            make.size.equalTo(CGSizeMake(kSCREENW, 44))
            make.top.equalTo(self)
        }
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(choiceButtonView.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }
        
        webView.snp_makeConstraints { (make) in
            make.top.equalTo(choiceButtonView.snp_bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    private lazy var webView: UIWebView = {
        let webView = UIWebView()
        /// 自动对页面进行缩放以适应屏幕
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .All
        webView.delegate = self
        return webView
    }()
    
    private lazy var choiceButtonView: YMDetailChoiceButtonView = {
        let choiceButtonView = YMDetailChoiceButtonView.choiceButtonView()
        choiceButtonView.delegate = self
        return choiceButtonView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.hidden = true
        let nib = UINib(nibName: String(YMCommentCell), bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: commentCellID)
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.rowHeight = 64
        return tableView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductDetailBottomView: YMDetailChoiceButtonViewDegegate, UIWebViewDelegate, UITableViewDataSource {
    
    // MARK: - YMDetailChoiceButtonViewDegegate
    func choiceIntroduceButtonClick() {
        tableView.hidden = true
        webView.hidden = false
    }
    
    func choicecommentButtonClick() {
        tableView.hidden = false
        webView.hidden = true
        
    }
    
    // MARK: - UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(commentCellID) as! YMCommentCell
        cell.comment = comments[indexPath.row]
        return cell
    }
    
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //点击弹出评论输入框

    }
   

}
