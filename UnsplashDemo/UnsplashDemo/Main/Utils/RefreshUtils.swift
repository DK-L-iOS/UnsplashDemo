//
//  RefreshUtils.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/10.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit

class RefreshUtils: NSObject {

	private var size:Int = 30
	private var originalFlag:String
	
	weak private var collectionView:UICollectionView?
	var finalFlag:String = ""
	
	init(scrollow:UIScrollView,flag:String,size:Int){
		if let collectionView = scrollow as? UICollectionView{
			self.collectionView = collectionView
		}
		self.originalFlag = flag
		self.size = size
	}
	
	func notifyBy(flag:String, clearData:(()->Void), appendData:(()->Void), insertRows:(()->(section:Int,start:Int,size:Int))){
		finalFlag = flag.replacingOccurrences(of: originalFlag, with: "")
		
		switch finalFlag {
		case PageFlag.kFristPage:
			
			UIView.performWithoutAnimation({
				// 清空数据
				clearData()
				
				// 添加数据
				appendData()
				
				collectionView?.reloadData()
				
				// 结束刷新
				collectionView?.endAllRefresh()
			})
			break
		case PageFlag.kFristPage_NoData:
			
			UIView.performWithoutAnimation({
				// 清空数据
				clearData()
				
				// 添加数据
				appendData()
				
				collectionView?.reloadData()
				
				// 结束刷新，没有数据
				collectionView?.endAllRefresh(true, true)
			})
			break
		case PageFlag.kFristPage_NoMoreData:
			
			UIView.performWithoutAnimation({
				// 清空数据
				clearData()
				
				// 添加数据
				appendData()
				
				collectionView?.reloadData()
				
				// 结束刷新，没有更多数据
				collectionView?.endAllRefresh(true, false)
			})
			break
		case PageFlag.kFristNormal:
			
			UIView.performWithoutAnimation({
				
				// 清空数据
				clearData()
				
				// 添加数据
				appendData()
				
				collectionView?.reloadData()
				
				// 结束刷新
				collectionView?.endAllRefresh()
			})
			break
		case PageFlag.kNormal:
			
			// 计数新增数据indexPaths
			let insertRow = insertRows()
			let start = insertRow.start; let size = insertRow.size;
			let section = insertRow.section
			
			// 添加数据
			appendData()
			
			// UI更新
			if size > 0 {
				var indexPaths = [IndexPath]()
				for index in start...start+size-1{
					indexPaths.append(IndexPath(row: index, section: section))
				}
				collectionView?.insertItems(at: indexPaths)
			}
			
			// 结束刷新
			collectionView?.endAllRefresh()
			
			break
		case PageFlag.KNoMore:
			
			// 计数新增数据indexPaths
			let insertRow = insertRows()
			let start = insertRow.start; let size = insertRow.size;
			let section = insertRow.section
			
			// 添加数据
			appendData()
			
			// UI更新
			if size > 0 {
				var indexPaths = [IndexPath]()
				for index in start...start+size-1{
					indexPaths.append(IndexPath(row: index, section: section))
				}
				collectionView?.insertItems(at: indexPaths)
			}
			
			// 结束刷新
			collectionView?.endAllRefresh(true, false)
			
			break
		case PageFlag.KNoData:
			
			// 结束刷新
			collectionView?.endAllRefresh(true, false)
			break
		default:
			// 结束刷新
			collectionView?.endAllRefresh()
			break
		}
	}
}
