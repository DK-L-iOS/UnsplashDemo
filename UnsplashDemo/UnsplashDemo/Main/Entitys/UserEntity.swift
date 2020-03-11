//
//  UserEntity.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit
import ObjectMapper

class UserEntity: NSObject, Mappable {

	var id:String?
	var username:String?
	var name:String?
	var portfolio_url:String?
	var bio:String?
	var location:String?
	var total_likes:Int?
	var total_photos:Int?
	var total_collections:Int?
	var profile_image:ProfileImageEntity?
	var links:LinksEntity?
	
	
	required init?(map: Map) {
	}
	
	func mapping(map: Map) {
		id <- map["id"]
		username <- map["username"]
		name <- map["name"]
		
		portfolio_url <- map["portfolio_url"]
		bio <- map["bio"]
		location <- map["location"]
		
		location <- map["location"]
		total_likes <- map["total_likes"]
		total_collections <- map["total_collections"]
		
		profile_image <- map["profile_image"]
		links <- map["links"]
	}
	
}
