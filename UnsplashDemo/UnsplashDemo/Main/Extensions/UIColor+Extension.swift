//
//  UIColor+Extension.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit


extension UIColor {
	
	/// 随机颜色
	class var random: UIColor {
		return UIColor(red: CGFloat(arc4random()%256) / 255.0, green: CGFloat(arc4random()%256) / 255.0, blue: CGFloat(arc4random()%256) / 255.0, alpha: 1.0)
	}
	
	/// 6位字符串转颜色
	///
	/// - Parameter cStr: 6位字符串转没有涉及透明度的颜色
	/// - Returns: 返回颜色
	class func color(cStr: String) -> UIColor {
		var color = UIColor.white
		
		let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
		//let rStr = cStr.substring(with: rRange)
		let rStr = String(cStr[rRange])
		
		let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
		//let gStr = cStr.substring(with: gRange)
		let gStr = String(cStr[gRange])
		
		let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
		//let bStr = cStr.substring(from: bIndex)
		let bStr = String(cStr[bIndex...])
		
		var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
		Scanner(string: rStr).scanHexInt32(&r)
		Scanner(string: gStr).scanHexInt32(&g)
		Scanner(string: bStr).scanHexInt32(&b)
		
		color = UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
		
		return color
	}
	
	
}

