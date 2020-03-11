//
//  ChoicenessCell.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit
import Kingfisher

class ChoicenessCell: UICollectionViewCell {

	lazy var imgView: UIImageView = {
		let tmpView = createImgView(.scaleAspectFill)
		return tmpView
	}()
	
	lazy var nameLab: UILabel = {
		let tmpView = createLabel(text: nil, textColor: UIColor.white, font: font_regular(13), textAlignment: .left)
		tmpView.adjustsFontSizeToFitWidth = true
		return tmpView
	}()
	
	var model:PhotoEntity?{
		didSet{
			if let colorStr = model?.color{
				backgroundColor = UIColor.color(cStr: colorStr)
			}
			imgView.loadImage(model?.urls?.thumb)
			
			nameLab.text = model?.user?.name
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		addSubview(imgView)
		imgView.snp.makeConstraints { (make) in
			make.edges.equalToSuperview()
		}
		
		addSubview(nameLab)
		nameLab.snp.makeConstraints { (make) in
			make.left.bottom.equalToSuperview()
			make.right.lessThanOrEqualToSuperview()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
