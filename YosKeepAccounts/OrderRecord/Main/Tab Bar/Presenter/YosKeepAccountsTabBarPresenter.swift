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
        
        //  首页
        let homeImg = UIImage(named: "账单_tab")
        let homeSelectedImg = UIImage(named: "账单_tab")
        let homeVC = childViewController(viewController: YosKeepAccountsHomePresenter.instance(),
                                         title: "首页",
                                         image: homeImg,
                                         selectedImage: homeSelectedImg,
                                         tag: 0)
        
        //  中间按钮
        let midVC = YosKeepAccountsBasePresenter()
        midVC.tabBarItem = ESTabBarItem.init(YosKeepAccountsIrregularityContentView(), title: nil, image: UIImage(named: "yka_orderAdd"), selectedImage: UIImage(named: "yka_orderAdd"))
        
        //  我的
        let meImg = UIImage(named: "我的_tab")
        let meSelectedImg = UIImage(named: "我的_tab")
        let meVC = childViewController(viewController: YosKeepAccountsMePresenter(),
                                       title: "我的",
                                       image: meImg,
                                       selectedImage: meSelectedImg,
                                       tag: 2)
        
        let tabBarVC = YosKeepAccountsTabBarPresenter()
        tabBarVC.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        tabBarVC.didHijackHandler = { tabBarViewController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let editOrderVC = YosKeepAccountsEditOrderPresenter.instance()
                guard let nav = tabBarViewController.selectedViewController else {
                    return
                }
                (nav as! UINavigationController).pushViewController(editOrderVC, animated: true)
            }
        }
        
        
        tabBarVC.viewControllers = [homeVC, midVC, meVC]
        return tabBarVC
    }
    
    static func childViewController(viewController: YosKeepAccountsBasePresenter,
                                    title: String,
                                    image: UIImage?,
                                    selectedImage: UIImage?,
                                    tag: Int) -> YosKeepAccountsBaseNavigationController {
        
        let childVC = YosKeepAccountsBaseNavigationController(rootViewController: viewController)
        
        let itemContentScene = YosKeepAccountsTabBarItemContentScene(frame: .zero)
        itemContentScene.highlightIconColor = UIColor.yka_main()
        itemContentScene.iconColor = UIColor.yka_unselected()
        
        let childItem =
            YosKeepAccountsTabBarItem(itemContentScene,
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
        
    }
    
}
