//
//  PhotoViewModel.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/10.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit

struct PhotoKey {
	static let kSize = 30
	static let kQueryPhotos = "kQueryPhotos"
}

class PhotoViewModel: BaseViewModel {

	lazy var dao: PhotoDao = {
		return PhotoDao()
	}()
	
	/** 分页查询图片*/
	func queryPhotos(page:Int){
		dao.queryPhotos(page: page, size: PhotoKey.kSize) { (result) in
			var  tmpArr = [PhotoEntity]()
			if let results = result?.data as? NSArray {
				for dict in results{
					guard let photo:PhotoEntity = getModel(dict: dict as? [String:AnyObject]) else {continue}
					tmpArr.append(photo)
				}
			}
			self.onPageResultModel(PhotoKey.kQueryPhotos, isPageFirst: page == 0, size: PhotoKey.kSize, results: tmpArr, result: result)
		}
	}
}
