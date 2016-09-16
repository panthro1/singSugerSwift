//
//  detailViewController.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/31.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit
import SVProgressHUD

class detailViewController: UIViewController {

    var Str :String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //添加全局的webview
         let webView = UIWebView()
        webView.frame = CGRectMake(0, 0, kSCREENW, kSCREENH-40)
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .All
        
        let url = NSURL(string: Str!)
        
        let request = NSURLRequest(URL:url!)
        
        webView.loadRequest(request)
        webView.delegate = self
        view.addSubview(webView)
        
        //添加底部导航栏
        let bottomBarview = UIView()
        bottomBarview.frame = CGRectMake(0, kSCREENH-40, kSCREENW, 40)
        bottomBarview.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(bottomBarview)
        
        
//        //底部栏添加是哪个button
//       for index in 0..<3 {
//           let button = getButton(index)
//         bottomBarview.addSubview(button)
//        }
//    
    }
//    func getButton(index:Int,name:String,imageName:String) -> UIButton {
//          let button = UIButton()
//        let buttonWide =
//        button.frame = CGRectMake(<#T##x: CGFloat##CGFloat#>, <#T##y: CGFloat##CGFloat#>, <#T##width: CGFloat##CGFloat#>, <#T##height: CGFloat##CGFloat#>)
//    }
//    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension detailViewController :UIWebViewDelegate{
 
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.setStatus("正在加载...")
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }

    
    func webViewDidFinishLoad(webView: UIWebView) {
        SVProgressHUD.dismiss()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }



}