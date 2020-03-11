//
//  UIScrollView+Extension.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit

var kUIScrollViewRefreshAndLoadKey = "kUIScrollViewRefreshAndLoadKey"
var kUIScrollViewIsRefreshingKey = "kUIScrollViewIsRefreshingKey"

protocol IRefreshAndLoadMore: class {
	func onRefresh()
	func onLoadMore()
}

//MARK:- 添加刷新和加载更多
extension UIScrollView {
	
	/// 刷新和加载更多代理
	weak var refreshLoadDelegate:IRefreshAndLoadMore?{
		get {
			return objc_getAssociatedObject(self, &kUIScrollViewRefreshAndLoadKey) as? IRefreshAndLoadMore
		}
		set {
			objc_setAssociatedObject(self, &kUIScrollViewRefreshAndLoadKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
		}
	}
	
	/// 是否正在刷新
	var isRefreshing:Bool{
		get {
			return mj_header.isRefreshing || mj_footer.isRefreshing
		}
	}
	
	/// 添加头部刷新
	func addRefresh() {
		let header = MJRefreshNormalHeader.init(refreshingTarget: self, refreshingAction: #selector(startRefresh))
		header?.lastUpdatedTimeLabel.isHidden = true
		header?.stateLabel.isHidden = true
		self.mj_header = header
	}
	/// 结束刷新
	func endRefresh(){
		if let mjHeader = self.mj_header, mjHeader.isRefreshing {
			mjHeader.endRefreshing()
		}
	}
	
	/// 添加加载更多
	func addLoadMore() {
		let footer = MJRefreshAutoNormalFooter.init(refreshingTarget: self, refreshingAction: #selector(startLoadMore))
		footer?.isRefreshingTitleHidden = true
		footer?.stateLabel.alpha = 0
		footer?.stateLabel.textColor = UIColor.gray
		footer?.stateLabel.font = font_regular(11)
		footer?.setTitle("没有更多数据", for: .noMoreData)
		self.mj_footer = footer
	}
	/// 结束加载更多
	func endLoadMore(_ isNoMoreData:Bool = false, _ isHidden:Bool = true){
		if let mjFooter = self.mj_footer as? MJRefreshAutoNormalFooter {
			UIView.animate(withDuration: 1.0) {
				mjFooter.stateLabel.alpha = isHidden ? 0:0
			}
			if isNoMoreData {
				mjFooter.endRefreshingWithNoMoreData()
			}else{
				mjFooter.endRefreshing()
			}
		}
	}
	/// 结束刷新或加载更多
	func endAllRefresh(_ isNoMoreData:Bool = false, _ isHidden:Bool = true){
		endRefresh()
		endLoadMore(isNoMoreData,isHidden)
	}
	/// 添加头部和尾部刷新
	func addRefreshAndLoadMore(){
		addRefresh()
		addLoadMore()
	}
	
	/// 移除头部和尾部刷新
	func removeRefreshAndLoadMore(){
		self.mj_footer = nil
		self.mj_header = nil
	}
	
	/// 没有更多数据
	func nomoreData(){
		if let mjFooter = self.mj_footer {
			mjFooter.endRefreshingWithNoMoreData()
		}
	}
	@objc func startRefresh(){
		if let mjFooter = self.mj_footer as? MJRefreshAutoNormalFooter {
			mjFooter.resetNoMoreData()
			mjFooter.stateLabel.alpha = 0
		}
		refreshLoadDelegate?.onRefresh()
	}
	@objc func startLoadMore(){
		refreshLoadDelegate?.onLoadMore()
	}
}

