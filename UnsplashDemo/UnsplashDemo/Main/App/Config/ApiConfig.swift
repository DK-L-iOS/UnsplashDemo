//
//  ApiConfig.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/10.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit


// MARK: - 获取照片Api
class ApiPhotoUrl:NSObject{
	
	/// 获取精选照片
	static let photos = "https://api.unsplash.com/photos"
}

struct PageFlag {
	//分页数据接口的标记
	static let kFristPage = "_frist"
	static let kFristPage_NoData = "_frist_no_data"
	static let kFristPage_NoMoreData = "_frist_no_more"
	static let kFristNormal = "frist_nromal"
	static let kNormal = "_nromal"
	static let KNoMore = "_no_more"
	static let KNoData = "_no_data"
}
