//
//  WaterfallLayout.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/10.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit

protocol WaterfallLayoutDelegate: class {
	func columnCount() ->Int
	func columnMargin() ->CGFloat
	func rowMargin() -> CGFloat
	func itemHeight(for indexPath:IndexPath) ->CGFloat
	func headerReferenceSize() ->CGSize
	func layoutEdgeInsets() ->UIEdgeInsets
}
class WaterfallLayout: UICollectionViewFlowLayout {
	
	weak var delegate:WaterfallLayoutDelegate?
	/// 所有cell的布局
	var attrsArray:[UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
	/// 每一列的高度，目前最大是3列
	var columnHeights:[CGFloat] = [CGFloat]()
	var columnCount:Int{
		get{
			guard let count = delegate?.columnCount() else {
				return 2
			}
			return count
		}
	}
	var columnMargin:CGFloat{
		get{
			guard let margin = delegate?.columnMargin() else {
				return 1
			}
			return margin
		}
	}
	var rowMargin:CGFloat{
		get{
			guard let margin = delegate?.rowMargin() else {
				return 1
			}
			return margin
		}
	}
	var headerSize:CGSize{
		get{
			guard let size = delegate?.headerReferenceSize() else {
				return CGSize.init(width: kScreenW, height: 0)
			}
			return size
		}
	}
	var edgeInsets:UIEdgeInsets{
		get{
			guard let edge = delegate?.layoutEdgeInsets() else {
				return UIEdgeInsets.zero
			}
			return edge
		}
	}
	override func prepare() {
		super.prepare()
		
		guard let itemCount = self.collectionView?.numberOfItems(inSection: 0),itemCount > 0 else {
			attrsArray.removeAll()
			return
		}
		
		columnHeights.removeAll()
		// 如果列还没有高度
		if columnHeights.count == 0 {
			for _ in 0...columnCount-1{
				// 每一列的起始y高度
				columnHeights.append(CGFloat(edgeInsets.top))
			}
		}
		
		attrsArray.removeAll()
		
		// 遍历cell
		for i in 0...itemCount-1 {
			let indexPath = IndexPath.init(row: i, section: 0)
			// 计算cell布局
			guard let attr = self.layoutAttributesForItem(at: indexPath) else {break}
			// 添加到数组
			attrsArray.append(attr)
		}
	}
	
	// 返回布局属性
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		return attrsArray
	}
	// 计算布局
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		
		if indexPath.row < attrsArray.count {return nil}
		
		let attr = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
		
		let collectionW = collectionView?.frame.width ?? 0
		
		let cellW = (collectionW - edgeInsets.left - edgeInsets.right - CGFloat(columnCount - 1) * columnMargin ) / CGFloat(columnCount)
		
		let cellH = delegate?.itemHeight(for: indexPath) ?? cellW
		
		// 查找最短的列
		var destColumn = 0
		var minHeight = self.columnHeights[0]
		if columnHeights.count <= 1 {return nil}
		for i in 1...columnHeights.count-1{
			let columnHeight = columnHeights[i]
			if Int(minHeight) > Int(columnHeight) {
				minHeight = columnHeight
				destColumn = i
			}
		}
		// 计算x
		let cellX = edgeInsets.left + CGFloat(destColumn) * (cellW + columnMargin)
		
		// 计算y
		var cellY = minHeight
		if cellY != edgeInsets.top{
			cellY += rowMargin
		}
		columnHeights[destColumn] = cellY + cellH
		attr.frame = CGRect.init(x: cellX, y: cellY, width: cellW, height: cellH)
		
		return attr
	}
	// 返回contentSize
	override var collectionViewContentSize: CGSize{
		if columnHeights.count > 1 {
			var maxHeight = self.columnHeights[0]
			for i in 1...columnHeights.count-1{
				let columnHeight = columnHeights[i]
				if Int(maxHeight) < Int(columnHeight) {
					maxHeight = columnHeight
				}
			}
			return CGSize.init(width: 0, height: maxHeight + edgeInsets.bottom)
		}
		return CGSize.init(width: 0, height: edgeInsets.bottom + edgeInsets.top)
	}
}



