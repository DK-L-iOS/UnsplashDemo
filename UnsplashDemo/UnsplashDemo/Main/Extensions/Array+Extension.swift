//
//  Array+Extension.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/10.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit



extension Array {
	
	//MARK: - 数组可以分段的取下标
	subscript(input: [Int]) -> ArraySlice<Element> {
		get {
			var array = ArraySlice<Element>()
			for i in input {
				assert(i < self.count, "Index out of range")
				array.append(self[i])
			}
			return array
		}set {
			for (index, i) in input.enumerated() {
				assert(i < self.count, "Index out of range")
				self[i] = newValue[index]
			}
		}
	}
	
	/// 添加非空元素
	mutating func appendNonNullElement(_ element:Element?) -> Void {
		if(element == nil){ return }
		self.append(element!)
	}
	
	/// 添加非空元素序列
	mutating func appendNonNullElements(_ elements:[Element?]?) -> Void {
		if(elements == nil || elements!.isEmpty){ return }
		for (_,item) in elements!.enumerated(){
			self.appendNonNullElement(item)
		}
	}
	
	/// 添加非空元素序列
	mutating func appendNonNullElement(_ elements:Element?...) -> Void {
		for (_,item) in elements.enumerated(){
			self.appendNonNullElement(item)
		}
	}
}
