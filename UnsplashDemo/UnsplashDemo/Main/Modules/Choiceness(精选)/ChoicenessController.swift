//
//  ChoicenessViewController.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit

class ChoicenessController: BaseViewController {

	var dataArr = [PhotoEntity]()
	private var page = 0
	lazy var photoViewModel: PhotoViewModel = {
		return PhotoViewModel(callback: self)
	}()
	lazy var refreshUtil: RefreshUtils = {
		let util = RefreshUtils.init(scrollow: collectionView, flag: PhotoKey.kQueryPhotos, size: PhotoKey.kSize)
		return util
	}()
	lazy var layout: WaterfallLayout = {
		let layout = WaterfallLayout()
		layout.delegate = self
		return layout
	}()
	lazy var collectionView: UICollectionView = {
		let tmpView = createCollectionView(frame: CGRect(x: 0, y: minY, width: kScreenW, height: maxHeightWithTabbar), layout: layout, delegate: self, dataSource: self)
		tmpView.register(cellWithClass: ChoicenessCell.self)
		tmpView.refreshLoadDelegate = self
		tmpView.addRefreshAndLoadMore()
		return tmpView
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.addSubview(collectionView)
		showActivityToast("加载中...", onView: view)
		loadData()
    }
	
	func loadData(){
		photoViewModel.queryPhotos(page: page)
	}
}
extension ChoicenessController: UICollectionViewDelegate,UICollectionViewDataSource{
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return dataArr.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let model = dataArr[indexPath.row]
		let cell = collectionView.dequeueReusableCell(withClass: ChoicenessCell.self, for: indexPath)
		cell.model = model
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		
		let cell = collectionView.cellForItem(at: indexPath) as? ChoicenessCell
		let model = dataArr[indexPath.row]
		
		// 数据源
		let dataSource = JXNetworkingDataSource(photoLoader: JXSDLoader(), numberOfItems: { () -> Int in
			return 1
		}, placeholder: { index -> UIImage? in
			return cell?.imgView.image
		}) { index -> String? in
			return model.urls?.regular
		}
		// 视图代理，实现了数字型页码指示器
		let delegate = JXNumberPageControlDelegate()
		// 转场动画
		let trans = JXPhotoBrowserZoomTransitioning { (browser, index, view) -> UIView? in
			return cell?.imgView
		}
		
		JXPhotoBrowser(dataSource: dataSource, delegate: delegate, transDelegate: trans).show(pageIndex: 0)
		
	}
}
extension ChoicenessController: WaterfallLayoutDelegate{
	func columnCount() -> Int {
		return 2
	}
	
	func columnMargin() -> CGFloat {
		return 1
	}
	
	func rowMargin() -> CGFloat {
		return 1
	}
	
	func itemHeight(for indexPath: IndexPath) -> CGFloat {
		let model = dataArr[indexPath.row]
		return model.getHeight()
	}
	
	func headerReferenceSize() -> CGSize {
		return CGSize.zero
	}
	
	func layoutEdgeInsets() -> UIEdgeInsets {
		return UIEdgeInsets.zero
	}
	
}
extension ChoicenessController:IRefreshAndLoadMore {
	func onRefresh() {
		page = 0
		loadData()
	}
	
	func onLoadMore() {
		page += 1
		loadData()
	}
}

extension ChoicenessController: IViewModelCallback{
	func onSuccessCallback(flag: String, result: Any?) {
		hiddenAllToast()
		if flag.contains(PhotoKey.kQueryPhotos){
			 let results = (result as? [PhotoEntity]) ?? [PhotoEntity]()
			refreshUtil.notifyBy(flag: flag, clearData: {
				dataArr.removeAll()
			}, appendData: {
				dataArr.appendNonNullElements(results)
			}) { () -> (section: Int, start: Int, size: Int) in
				return (0, dataArr.count, results.count)
			}
		}
	}
	func onFailCallback(flag: String, msg: String?) {
		showErrorToast(msg, onView: view)
	}
}

