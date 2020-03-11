//
//  PhotoDao.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/10.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit
import Alamofire

class PhotoDao: NSObject {

	/** 分页查询图片，需求简单，未封装*/
	func queryPhotos(page:Int,size:Int,callback:ApiCallBack?){
		HttpUtils.request(method: HTTPMethod.get, url: ApiPhotoUrl.photos, params: ["client_id":AppConfig.ACCESS_KEY,"per_page":size,"page":page*size], headers: nil, callback: callback)
	}
	
}
