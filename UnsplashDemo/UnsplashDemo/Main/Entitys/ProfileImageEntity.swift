//
//  ImageEntity.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit
import ObjectMapper

class ProfileImageEntity: NSObject, Mappable{
	
	var small:String?
	var medium:String?
	var large:String?
	var download:String?
	
	
	required init?(map: Map) {
	}
	
	func mapping(map: Map) {
		small <- map["small"]
		medium <- map["medium"]
		large <- map["large"]
		download <- map["download"]
	}
}

//MARK:- UrlsEntity
class UrlsEntity: NSObject, Mappable{
	
	var raw:String?
	var full:String?
	var regular:String?
	var small:String?
	var thumb:String?
	
	
	required init?(map: Map) {
	}
	
	func mapping(map: Map) {
		raw <- map["raw"]
		full <- map["full"]
		regular <- map["regular"]
		small <- map["small"]
		thumb <- map["thumb"]
	}
}

//MARK:- LinksEntity
class LinksEntity: NSObject, Mappable{
	
	var selff:String?
	var html:String?
	var photos:String?
	var likes:String?
	var protfolio:String?
	
	required init?(map: Map) {
	}
	
	func mapping(map: Map) {
		selff <- map["self"]
		html <- map["html"]
		photos <- map["photos"]
		likes <- map["likes"]
		protfolio <- map["protfolio"]
	}
}
