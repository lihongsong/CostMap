//
//  CostMapTabBarItemContentScene.swift
//  CostMap
//
//

import ESTabBarController_swift;

class CostMapTabBarItemContentScene: ESTabBarItemContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.highlightTextColor = UIColor.yka_main()
        self.textColor = UIColor.yka_unselected()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateDisplay() {
        
        var currentImage: UIImage?
        
        if selected {
            currentImage = selectedImage
        } else {
            currentImage = image
        }
        
        startAnimate(currentImage)
        
        imageView.tintColor = selected ? highlightIconColor : iconColor
        titleLabel.textColor = selected ? highlightTextColor : textColor
        backgroundColor = selected ? highlightBackdropColor : backdropColor
        
    }
    
    func startAnimate(_ animateImage: UIImage?) {
        
        guard let count = animateImage?.images?.count else {
            imageView.image = animateImage
            return
        }
        
        imageView.image = animateImage?.images?.last
        
        guard let tempAnimateImage = animateImage else {
            return
        }
        
        let totalDuration = tempAnimateImage.duration
        let perDuration = totalDuration / Double(count)
        let animate = CAKeyframeAnimation(keyPath: "contents")
        
        var percentageArray: [NSNumber] = []
        var animateImages: [Any] = []
        
        for var i in 0..<count {
            let number = NSNumber(value: perDuration * Double(i))
            percentageArray.append(number)
            
            if let images = tempAnimateImage.images {
                let image = images[i]
                if let cgImage = image.cgImage {
                    animateImages.append(cgImage)
                }
            }
        }
        
        animate.values = animateImages
        animate.duration = totalDuration
        animate.repeatCount = 1
        animate.fillMode = CAMediaTimingFillMode.forwards
        animate.isRemovedOnCompletion = true
        animate.keyTimes = percentageArray
        animate.timingFunctions = [CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)]
        
        imageView.layer.add(animate, forKey: "gifAnimation")
    }
    
}

