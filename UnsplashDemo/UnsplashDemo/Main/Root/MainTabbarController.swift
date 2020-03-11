//
//  MainTabbarController.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		
		let homeVC = ChoicenessController()
		addChildVC(childVC: homeVC, title: "精选", image: nil, selectImage: nil)
		
		
		let skillVC = MyInfoController()
		addChildVC(childVC: skillVC, title: "我", image: nil, selectImage: nil)
		

        // Do any additional setup after loading the view.
    }
	
	func addChildVC(childVC:UIViewController, title: String, image: UIImage?, selectImage: UIImage?){
		childVC.title = title
		childVC.tabBarItem = UITabBarItem(title: title, image: (image ?? UIImage()).withRenderingMode(.alwaysOriginal), selectedImage: (selectImage ?? UIImage()).withRenderingMode(.alwaysOriginal))
		let naviVC = RootNavigationController(rootViewController: childVC)
		addChild(naviVC)
	}

}
