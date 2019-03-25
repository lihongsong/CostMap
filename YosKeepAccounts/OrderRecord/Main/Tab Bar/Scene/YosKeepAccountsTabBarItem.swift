//
//  YosKeepAccountsTabBarItem.swift
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

import ESTabBarController_swift

class YosKeepAccountsTabBarItem: ESTabBarItem {
    
    @objc public override init(_ contentView: ESTabBarItemContentView = ESTabBarItemContentView(), title: String? = nil, image: UIImage? = nil, selectedImage: UIImage? = nil, tag: Int = 0) {
        super.init(contentView, title: title, image: image, selectedImage: selectedImage, tag: tag)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
