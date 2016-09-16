//
//  zhuantiModel.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/30.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class zhuantiModel: NSObject {
//    "banner_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150809/a5h1ygeaz.jpg-w300",
//    "cover_image_url": "http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150809/xcfrysr3i.jpg-w720",
//    "created_at": 1439086194,
//    "id": 4,
//    "posts_count": 3,
//    "status": 0,
//    "subtitle": "实用神器合辑",
//    "title": "生活中的实用神器",
//    "updated_at": 1439086194
    
    
    var status: Int?
    
    var banner_image_url: String?
    
    var subtitle: String?
    
    var id: Int?
    
    var created_at: Int?
    
    var title: String?
    
    var cover_image_url: String?
    
    var updated_at: Int?
    
    var posts_count: Int?
    
    init(dict: [String: AnyObject]) {
        super.init()
        status = dict["status"] as? Int
        banner_image_url = dict["banner_image_url"] as? String
        subtitle = dict["subtitle"] as? String
        id = dict["id"] as? Int
        created_at = dict["created_at"] as? Int
        title = dict["title"] as? String
        cover_image_url = dict["cover_image_url"] as? String
        updated_at = dict["updated_at"] as? Int
        posts_count = dict["posts_count"] as? Int
    }

    

}
