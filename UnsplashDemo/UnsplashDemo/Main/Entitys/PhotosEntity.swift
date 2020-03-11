//
//  LinksEntity.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit
import ObjectMapper

class PhotoEntity: NSObject, Mappable{
	
	var id:String?
	var created_at:String?
	var width:Int = 1
	var height:Int = 1
	var color:String?
	var likes:Int?
	var user:UserEntity?
	var urls:UrlsEntity?
	var links:LinksEntity?
	
	required init?(map: Map) {
	}
	
	func mapping(map: Map) {
		id <- map["id"]
		created_at <- map["created_at"]
		width <- map["width"]
		height <- map["height"]
		color <- map["color"]
		likes <- map["likes"]
		user <- map["user"]
		urls <- map["urls"]
		links <- map["links"]
	}
	// 用于计算瀑布流中高度
	func getHeight() ->CGFloat{
		let scale = CGFloat(height) / CGFloat(width)
		let show_w = (kScreenW - 1) / 2
		return show_w * scale
	}
	
}


class PhotosEntity: NSObject, Mappable{

	var total:Int?
	var total_pages:Int?
	var results:[PhotoEntity]?
	
	required init?(map: Map) {
	}

	func mapping(map: Map) {
		total <- map["total"]
		total_pages <- map["total_pages"]
		results <- map["results"]
	}
}
