//
//  ToastManager.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/10.
//  Copyright © 2019年 lidengke. All rights reserved.
//

import UIKit

class ToastManager: NSObject {
	
	static let manager = ToastManager()
	
	var hud = MBProgressHUD()
	/** 成功tHUD*/
	class func showText(msg:String?,view:UIView? = nil){
		let onView = view ?? UIApplication.shared.keyWindow!
		hiddenAllHUD()
		manager.hud = MBProgressHUD.showAdded(to: onView, animated: true)
		manager.hud.mode = .text
		manager.hud.label.text = msg
		manager.hud.label.font = UIFont.systemFont(ofSize: 14)
		manager.hud.contentColor = UIColor.white
		manager.hud.bezelView.style = .solidColor
		manager.hud.margin = 15
		manager.hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
		manager.hud.hide(animated: true, afterDelay: 1.0)
	}
	/** 显示HUD*/
	class func showActivity(msg:String?,view:UIView? = nil){
		let onView = view ?? UIApplication.shared.keyWindow!
		hiddenAllHUD()
		manager.hud = MBProgressHUD.showAdded(to: onView, animated: true)
		manager.hud.label.text = msg
		manager.hud.label.font = UIFont.systemFont(ofSize: 14)
		manager.hud.contentColor = UIColor.white
		manager.hud.bezelView.style = .solidColor
		manager.hud.margin = 15
		manager.hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
	}
	/** 进度HUD*/
	class func showProgress(_ view:UIView? = nil){
		let onView = view ?? UIApplication.shared.keyWindow!
		hiddenAllHUD()
		manager.hud = MBProgressHUD.showAdded(to: onView, animated: true)
		manager.hud.mode = .determinate
		manager.hud.progress = 0
		manager.hud.label.text = "1%"
		manager.hud.contentColor = UIColor.white
		manager.hud.bezelView.style = .blur
		manager.hud.label.font = UIFont.systemFont(ofSize: 14)
		manager.hud.margin = 15
		manager.hud.bezelView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
	}
	/** 设置进度HUD*/
	class func setProgress(progress:CGFloat){
		manager.hud.progress = Float(progress)
		manager.hud.label.text = String.init(format: "%d%%", max(1,Int(progress*100)))
		if progress >= 1 {
			manager.hud.hide(animated: true, afterDelay: 0.15)
		}
	}
	/** 取消HUD*/
	class func hiddenAllHUD(){
		manager.hud.hide(animated: true)
	}
	
}
