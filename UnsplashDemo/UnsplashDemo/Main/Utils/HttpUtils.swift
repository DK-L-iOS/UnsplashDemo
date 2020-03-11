//
//  HttpUtils.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/10.
//  Copyright © 2019年 lidengke. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


typealias ApiCallBack = ((_ data:RespondResult?)->Void)

/*
网络请求工具类,处理网络请求和网络缓存方案
*/
class HttpUtils{
	/** 取消所有请求*/
	class func cancelRequest(){
		SessionManager.default.session.getTasksWithCompletionHandler { (tasks, uploadTasks, downTasks) in
			tasks.forEach({ (task) in
				task.cancel()
			})
			uploadTasks.forEach({ (task) in
				task.cancel()
			})
			downTasks.forEach({ (task) in
				task.cancel()
			})
		}
	}
	/// App内部所有接口调用
	class func request(
		sessionManage:SessionManager=SessionManager.default,//sessionManage
		method:HTTPMethod,
		url:String, //请求Url
		params: Parameters?, //请求参数:[String: Any]
		headers: HTTPHeaders?,
		callback:ApiCallBack?)
	{
		//Api日志打印
		print("url:", url, ",method:", method.rawValue, ",params:", params)
		
		//正式请求
		sessionManage.request(url,
							  method: method,
							  parameters: params,
							  encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
							  headers: headers)
			.responseJSON { (resultData) in
				switch resultData.result{
				case .success(let successValue):
					let result = RespondResult.init(data: successValue, code: 200, msg: nil)
					callback?(result)
					break
				case .failure(let error):
					let result = RespondResult.init(data: nil, code: nil, msg: error.localizedDescription)
					callback?(result)
					print("HTTP响应Code非200,",error)
					break
				}
		}
	}
}
