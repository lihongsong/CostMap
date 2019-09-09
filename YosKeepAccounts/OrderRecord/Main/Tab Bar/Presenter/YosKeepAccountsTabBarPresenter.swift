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
        
        let homeImg = UIImage(named: "main_tab")
        let homeSelectedImg = UIImage(named: "main_tab")
        let homeVC = childViewController(viewController: YosKeepAccountsHomePresenter.instance(),
                                         title: "Main",
                                         image: homeImg,
                                         selectedImage: homeSelectedImg,
                                         tag: 0)
        
        let midVC = YosKeepAccountsBasePresenter()
        midVC.tabBarItem = ESTabBarItem.init(YosKeepAccountsIrregularityContentView(), title: nil, image: UIImage(named: "yka_orderAdd"), selectedImage: UIImage(named: "yka_orderAdd"))

        let meImg = UIImage(named: "chart_tab")
        let meSelectedImg = UIImage(named: "chart_tab")
        let meVC = childViewController(viewController: YosKeepAccountsChartPresenter.instance(),
                                       title: "Chart",
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
                curNav(tabBarViewController)?.pushViewController(editOrderVC, animated: true)
            }
        }
        
        
        tabBarVC.viewControllers = [homeVC, midVC, meVC]
        return tabBarVC
    }
    
    static func curNav (_ tabBarViewController: UITabBarController) -> UINavigationController? {
        guard let nav = tabBarViewController.selectedViewController else {
            return nil
        }
        guard let tempNav = nav as? UINavigationController else {
            return nil
        }
        return tempNav
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
