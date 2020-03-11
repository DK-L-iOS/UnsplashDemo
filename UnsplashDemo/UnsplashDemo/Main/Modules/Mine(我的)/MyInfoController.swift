//
//  MyViewController.swift
//  UnsplashDemo
//
//  Created by lidengke on 2020/3/9.
//  Copyright © 2020 lidengke. All rights reserved.
//

import UIKit

class MyInfoController: BaseViewController {

	lazy var infoLab: UILabel = {
		let tmpView = createLabel(text: "说明\n\n网络环境比较恶劣，访问Unsplash页面比较吃力，代码略显粗糙，若理解有误，敬请谅解！", textColor: UIColor.black, font: font_regular(15), textAlignment: .center)
		tmpView.numberOfLines = 0
		return tmpView
	}()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		view.addSubview(infoLab)
		infoLab.snp.makeConstraints { (make) in
			make.width.equalToSuperview().multipliedBy(0.7)
			make.centerX.height.equalToSuperview()
			
		}

    }
}
