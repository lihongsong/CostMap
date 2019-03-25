//
//  YosKeepAccountsTabBarPresenter.swift
//  YosKeepAccounts
//
//  Created by yoser on 2019/3/25.
//  Copyright © 2019 yoser. All rights reserved.
//

import ESTabBarController_swift;

@objc class YosKeepAccountsTabBarPresenter: ESTabBarController {
    
    @objc public static func createRootViewController() -> YosKeepAccountsTabBarPresenter {
        
        //        首页
        let homeImg = UIImage(named: "1")
        let homeSelectedImg = UIImage(named: "1")
        let homeVC = childViewController(viewController: YosKeepAccountsHomePresenter.instance(),
                                         title: "首页",
                                         image: homeImg,
                                         selectedImage: homeSelectedImg,
                                         tag: 0)
        
        let otherImg = UIImage(named: "1")
        let otherSelectedImg = UIImage(named: "1")
        let otherVC = childViewController(viewController: YosKeepAccountsBasePresenter(),
                                          title: "其他",
                                          image: otherImg,
                                          selectedImage: otherSelectedImg,
                                          tag: 1)
        
        let meImg = UIImage(named: "1")
        let meSelectedImg = UIImage(named: "1")
        let meVC = childViewController(viewController: YosKeepAccountsMePresenter(),
                                       title: "我的",
                                       image: meImg,
                                       selectedImage: meSelectedImg,
                                       tag: 2)
        
        let tabBarVC = YosKeepAccountsTabBarPresenter()
        tabBarVC.viewControllers = [homeVC, otherVC, meVC]
        
        return tabBarVC
    }
    
    static func childViewController(viewController: YosKeepAccountsBasePresenter,
                                    title: String,
                                    image: UIImage?,
                                    selectedImage: UIImage?,
                                    tag: Int) -> YosKeepAccountsBaseNavigationController {
        
        let childVC = YosKeepAccountsBaseNavigationController(rootViewController: viewController)
        
        let childItem =
            YosKeepAccountsTabBarItem(YosKeepAccountsTabBarItemContentScene(frame: .zero),
                                      title: title,
                                      image: image,
                                      selectedImage: selectedImage,
                                      tag: tag)
        childVC.tabBarItem = childItem
        return childVC
    }
    
    @objc var yka_selectedViewController: UIViewController? {
        let vc = self.selectedViewController
        if vc is YosKeepAccountsBaseNavigationController {
            let rc = vc as! YosKeepAccountsBaseNavigationController
            return rc.topViewController
        }
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        delegate = self
        // Do any additional setup after loading the view.
    }
    
}
