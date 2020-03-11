//
//  UIImageView+Extension.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/10.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView{
	
	/** 加载图片*/
	func loadImage(_ urlStr:String?){
		guard let urlStr = urlStr, let url = URL.init(string: urlStr) else { return }
		self.kf.setImage(with: url)
		self.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.25)),.onlyFromCache], progressBlock: nil, completionHandler: nil)
	}
	
	
	
}
