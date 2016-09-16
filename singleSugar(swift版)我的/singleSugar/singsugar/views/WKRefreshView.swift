//
//  WKRefreshView.swift
//  singleSugar
//
//  Created by 汪凯 on 16/8/26.
//  Copyright © 2016年 汪凯. All rights reserved.
//

import UIKit

class WKRefreshView: UIView {
/// 箭头向下
    @IBOutlet weak var iconView: UIImageView!
    /// 刷新
    @IBOutlet weak var loadingView: UIImageView!
    /// 遮盖view
    @IBOutlet weak var tipView: UIView!
    
    
    
    /// 旋转箭头
    func rotationArrowIcon(flag: Bool) {
        var angle = M_PI
        angle += flag ? -0.01 : 0.01
        UIView.animateWithDuration(kAnimationDuration) {
            self.iconView.transform = CGAffineTransformRotate(self.iconView.transform, CGFloat(angle))
        }
    }
    
    /// 开始转圈动画
    func startLodingViewAnimation() {
        
        tipView.hidden = true
        // 创建动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.duration = 1
        animation.repeatCount = MAXFLOAT
        animation.removedOnCompletion = false
        loadingView.layer.addAnimation(animation, forKey: nil)
    }
    
    /// 停止转圈动画
    func stopLodingViewAnimation() {
        tipView.hidden = false
        loadingView.layer.removeAllAnimations()
    }
    
    class func refreshView() -> WKRefreshView {
        return NSBundle.mainBundle().loadNibNamed(String(self), owner: nil, options: nil).last as! WKRefreshView
    }
    
}
    
    
    

