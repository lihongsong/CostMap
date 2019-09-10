//
//  CostMapTabBarPresenter.swift
//  CostMap
//
//

import ESTabBarController_swift;

@objc class CostMapTabBarPresenter: ESTabBarController {
    
    @objc public static func createRootViewController() -> CostMapTabBarPresenter {
        
        let homeImg = UIImage(named: "main_tab")
        let homeSelectedImg = UIImage(named: "main_tab")
        let homeVC = childViewController(viewController: CostMapHomePresenter.instance(),
                                         title: "Main",
                                         image: homeImg,
                                         selectedImage: homeSelectedImg,
                                         tag: 0)
        
        let midVC = CostMapBasePresenter()
        midVC.tabBarItem = ESTabBarItem.init(CostMapIrregularityContentView(), title: nil, image: UIImage(named: "yka_orderAdd"), selectedImage: UIImage(named: "yka_orderAdd"))

        let meImg = UIImage(named: "chart_tab")
        let meSelectedImg = UIImage(named: "chart_tab")
        let meVC = childViewController(viewController: CostMapChartPresenter.instance(),
                                       title: "Chart",
                                       image: meImg,
                                       selectedImage: meSelectedImg,
                                       tag: 2)
        
        let tabBarVC = CostMapTabBarPresenter()
        tabBarVC.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        tabBarVC.didHijackHandler = { tabBarViewController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let editOrderVC = CostMapEditOrderPresenter.instance()
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
    
    static func childViewController(viewController: CostMapBasePresenter,
                                    title: String,
                                    image: UIImage?,
                                    selectedImage: UIImage?,
                                    tag: Int) -> CostMapBaseNavigationController {
        
        let childVC = CostMapBaseNavigationController(rootViewController: viewController)
        
        let itemContentScene = CostMapTabBarItemContentScene(frame: .zero)
        itemContentScene.highlightIconColor = UIColor.yka_main()
        itemContentScene.iconColor = UIColor.yka_unselected()
        
        let childItem =
            CostMapTabBarItem(itemContentScene,
                                      title: title,
                                      image: image,
                                      selectedImage: selectedImage,
                                      tag: tag)
        childVC.tabBarItem = childItem
        return childVC
    }
    
    @objc var yka_selectedViewController: UIViewController? {
        let vc = self.selectedViewController
        if vc is CostMapBaseNavigationController {
            let rc = vc as! CostMapBaseNavigationController
            return rc.topViewController
        }
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
