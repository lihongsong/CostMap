//
//  CostMapTabBarItem.swift
//  CostMap
//
//

import ESTabBarController_swift

class CostMapTabBarItem: ESTabBarItem {
    
    @objc public override init(_ contentView: ESTabBarItemContentView = ESTabBarItemContentView(), title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil, tag: Int = 0) {
        super.init(contentView, title: title, image: image, selectedImage: selectedImage, tag: tag)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
