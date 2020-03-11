//
//  UIConfig.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit

/** 是否具有安全距离*/
func hasSafeArea()->Bool{
	if #available(iOS 11.0, *), let delegate = UIApplication.shared.delegate as? AppDelegate, let window = delegate.window {
		return window.safeAreaInsets.bottom > 0
	} else {
		return false
	}
}
let is_iPhoneXAll:Bool = hasSafeArea()

/** 顶部安全距离*/
let kSafeTop:CGFloat = is_iPhoneXAll ? 24 : 0
/** 底部安全距离*/
let kSafeBottom:CGFloat = is_iPhoneXAll ? 34 : 0
/** 屏幕宽*/
let kScreenW:CGFloat = UIScreen.main.bounds.width
/** 屏幕高*/
let kScreenH:CGFloat = UIScreen.main.bounds.height
/** 状态栏高*/
let kStatusBarH:CGFloat = is_iPhoneXAll ? 44:20
/** 导航栏高*/
let kNaviBarH:CGFloat = kStatusBarH + 44
/** 标签栏高*/
let kTabBarH:CGFloat = kSafeBottom + 49



