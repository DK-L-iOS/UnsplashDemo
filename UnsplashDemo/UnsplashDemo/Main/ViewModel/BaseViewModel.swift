//
//  BaseViewModel.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/10.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit

/** 请求响应实体*/
class RespondResult: NSObject {
	
	var data:Any?
	var msg:String?
	var code:Int?
	
	init(data:Any?, code:Int?, msg:String?){
		self.data = data
		self.code = code
		self.msg = msg
	}
	
	/** 200为http状态码，业务状态码需要与后台商定*/
	func isSuccess() ->Bool{
		return code == 200
	}
}


//MARK:- ViewModel回调
protocol IViewModelCallback:class{
	
	/* ViewModel成功回调 */
	func onSuccessCallback(flag:String,result:Any?)
	/* ViewModel失败回调 */
	func onFailCallback(flag:String,msg:String?)
}

//MARK:- ViewModel基类，提供统一回调（协议回调，可增加闭包）
class BaseViewModel: NSObject {

	weak var callback:IViewModelCallback?
	public init(callback:IViewModelCallback?=nil){
		self.callback=callback
		super.init()
	}
	
	/// 回调,统一的flag
	func onResultModel(_ flag:String,result:RespondResult?,_ resultModel:Any?){
		if getBool(result?.isSuccess()) {
			callback?.onSuccessCallback(flag: flag, result: resultModel)
		}else{
			callback?.onFailCallback(flag: flag, msg: result?.msg)
		}
	}
	
	
	
	/// 分页回调,统一的flag
	func onPageResultModel(_ flag:String,isPageFirst:Bool,size:Int,results:[Any]?,result:RespondResult?){
		if getBool(result?.isSuccess()) {
			var newFlag = ""
			if isPageFirst {
				if let r = results, r.count > 0 {
					if r.count < size{
						newFlag = flag.appending(PageFlag.kFristPage_NoMoreData)
					}else{
						newFlag = flag.appending(PageFlag.kFristNormal)
					}
				}else{
					newFlag = flag.appending(PageFlag.kFristPage_NoData)
				}
			}else{
				if let r = results {
					if r.count < size{
						newFlag = flag.appending(PageFlag.KNoMore)
					}else{
						newFlag = flag.appending(PageFlag.kNormal)
					}
				}else{
					newFlag = flag.appending(PageFlag.KNoData)
				}
			}
			callback?.onSuccessCallback(flag: newFlag, result: results)
		}
		else{
			callback?.onFailCallback(flag: flag, msg: result?.msg)
		}
	}
}
