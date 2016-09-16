//
//  SearchRecordView.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/26.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class SearchRecordView: UIView {
    /// 关键词
    var words = [String]()
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        
        let Url = "v1/search/hot_words"
        //网络请求 关键词
        NetworkTools.shareNetworkTool.loadGETRequestDataInfoWithOutParmas(Url) { [weak self] (dataDict) in
            
            if let hot_words = dataDict["hot_words"]?.arrayObject {
                self!.words   = (words: hot_words as! [String])
            }
            self!.setupUI()
        }

    }
    
    
    func setupUI() {
        
        // 大家都在搜
        let topView = UIView()
        addSubview(topView)
        let hotLabel = setupLabel("大家都在搜")
        hotLabel.frame = CGRectMake(10, 20, 200, 20)
        topView.addSubview(hotLabel)
        
        
        // 历史纪录
        let bottomView = UIView()
        
        addSubview(bottomView)
    }
    
    
    
    func setupLabel(title: String) -> UILabel{
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = WKColor(0, g: 0, b: 0, a: 0.6)
        return label
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
