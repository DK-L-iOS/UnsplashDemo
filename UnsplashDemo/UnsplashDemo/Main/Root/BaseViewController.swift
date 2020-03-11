//
//  BaseViewController.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

	/** 导航栏控制器视图最小Y值*/
	let minY = kNaviBarH
	/** 导航栏控制器视图不包含标签栏最大高度*/
	let maxHeight = kScreenH - kNaviBarH// - kSafeBottom
	/** 导航栏控制器视图包含标签栏最大高度*/
	let maxHeightWithTabbar = kScreenH - kNaviBarH - kTabBarH
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.white

        // Do any additional setup after loading the view.
    }
	
	deinit {
		print("控制器销毁--",String(describing: self))
	}
}
