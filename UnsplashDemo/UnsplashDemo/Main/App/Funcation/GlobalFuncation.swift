//
//  GlobalFuncation.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit
import ObjectMapper

//MARK:- 快速创建控件
/** 创建UIImageView控件*/
func createImgView(_ contentMode:UIView.ContentMode,_ isUserInteractionEnabled:Bool = true,_ clipsToBounds:Bool = true) -> UIImageView{
	let view = UIImageView()
	view.contentMode  = contentMode
	view.clipsToBounds = clipsToBounds
	view.isUserInteractionEnabled = isUserInteractionEnabled
	return view
}
/** 创建UICollectionView控件*/
func createCollectionView(frame:CGRect,layout:UICollectionViewLayout,delegate:UICollectionViewDelegate,dataSource:UICollectionViewDataSource) ->UICollectionView{
	let tmpView = UICollectionView.init(frame: frame, collectionViewLayout: layout)
	tmpView.delegate = delegate
	tmpView.dataSource = dataSource
	tmpView.backgroundColor = UIColor.white
	tmpView.alwaysBounceVertical = true
	tmpView.showsHorizontalScrollIndicator = false
	return tmpView
}

/** 创建UILabel控件*/
func createLabel(text:String?,textColor:UIColor?,font:UIFont?,textAlignment:NSTextAlignment?) -> UILabel{
	let lab = UILabel()
	lab.text = text
	lab.textColor = textColor
	lab.font = font
	lab.textAlignment = textAlignment ?? .left
	return lab
}


//MARK:- 显示吐司
/** 显示文字提示*/
func showTextToast(_ msg:String?, onView:UIView? = nil, complete:(()->())? = nil){
	ToastManager.showText(msg: msg, view: onView)
	dispatch_main_async_after(delay: 1.0) {
		complete?()
	}
}
func showErrorToast(_ msg:String?, onView:UIView? = nil, complete:(()->())? = nil){
	ToastManager.showText(msg: msg, view: onView)
	dispatch_main_async_after(delay: 1.0) {
		complete?()
	}
}
/** 显示菊花、文字提示*/
func showActivityToast(_ msg:String?, onView:UIView? = nil){
	ToastManager.showActivity(msg: msg, view: onView)
}
/** 隐藏toast提示*/
func hiddenAllToast(){
	ToastManager.hiddenAllHUD()
}



//MARK:- 字典转模型
/** 将继承Mappable的字典转模型*/
func getModel<T:Mappable>(dict:[String:Any]?) -> T?{
	if(dict == nil) { return nil }
	return T(JSON: dict!)
}
/** 将继承Mappable的JSON字符串转模型*/
func getModel<T:Mappable>(json:String?) -> T?{
	if(json == nil) { return nil }
	return T.init(JSONString: json!)
}


//MARK:- 布尔值
func getBool(_ bool:Bool?) -> Bool {
	return bool ?? false
}


//MARK:- 线程操作
/** 主线程同步队列*/
func dispatch_main_async_safe(block:@escaping ()->()){
	if Thread.isMainThread {
		block()
	}else{
		DispatchQueue.main.async {
			block()
		}
	}
}
/** 延时执行*/
func dispatch_main_async_after(delay:TimeInterval,block:@escaping ()->()){
	let time = DispatchTime.now() + delay
	DispatchQueue.main.asyncAfter(deadline: time) {
		block()
	}
}


//MARK:- 快速创建字体
/** 常规字体*/
func font_regular(_ font:CGFloat)->UIFont{
	return UIFont.systemFont(ofSize:font)
}
/** 粗体*/
func font_bold(_ font:CGFloat)->UIFont{
	return UIFont.boldSystemFont(ofSize: font)
}
