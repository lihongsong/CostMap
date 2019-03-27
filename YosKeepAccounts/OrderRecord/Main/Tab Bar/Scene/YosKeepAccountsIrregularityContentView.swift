//
//  YosKeepAccountsIrregularityContentView.swift
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class YosKeepAccountsIrregularityContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView.backgroundColor = UIColor.white
        self.imageView.layer.borderWidth = 3.0
        self.imageView.layer.borderColor = UIColor.white.cgColor
        self.insets = UIEdgeInsets.init(top: -32, left: 0, bottom: 0, right: 0)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        self.superview?.bringSubviewToFront(self)

        textColor = UIColor.yka_main()
        highlightTextColor = UIColor.yka_unselected()
        iconColor = UIColor.yka_main()
        highlightIconColor = UIColor.yka_unselected()
        backdropColor = UIColor.clear
        highlightBackdropColor = UIColor.clear
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint.init(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
        return sqrt(pow(imageView.bounds.size.width / 2.0 - p.x, 2) + pow(imageView.bounds.size.height / 2.0 - p.y, 2)) < imageView.bounds.size.width / 2.0
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        
        let width = imageView.hj_width + 6
        let height = imageView.hj_height + 6
        
        self.imageView.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
        self.imageView.layer.cornerRadius = width * 0.5
    }
    
    public override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        completion?()
    }
    
    public override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        completion?()
    }
    
    public override func deselectAnimation(animated: Bool, completion: (() -> ())?) {
        completion?()
    }
    
    public override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = self.imageView.transform.scaledBy(x: 0.8, y: 0.8)
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    public override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = CGAffineTransform.identity
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    private func playMaskAnimation(animateView view: UIView, target: UIView, completion: (() -> ())?) {
        view.center = CGPoint.init(x: target.frame.origin.x + target.frame.size.width / 2.0, y: target.frame.origin.y + target.frame.size.height / 2.0)
        
        let scale = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
        scale?.fromValue = NSValue.init(cgSize: CGSize.init(width: 1.0, height: 1.0))
        scale?.toValue = NSValue.init(cgSize: CGSize.init(width: 36.0, height: 36.0))
        scale?.beginTime = CACurrentMediaTime()
        scale?.duration = 0.3
        scale?.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
        scale?.removedOnCompletion = true
        
        let alpha = POPBasicAnimation.init(propertyNamed: kPOPLayerOpacity)
        alpha?.fromValue = 0.6
        alpha?.toValue = 0.6
        alpha?.beginTime = CACurrentMediaTime()
        alpha?.duration = 0.25
        alpha?.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
        alpha?.removedOnCompletion = true
        
        view.layer.pop_add(scale, forKey: "scale")
        view.layer.pop_add(alpha, forKey: "alpha")
        
        scale?.completionBlock = ({ animation, finished in
            completion?()
        })
    }

}
