//
//  JXSDLoader.swift
//  JXPhotoBrowser
//
//  Created by JiongXing on 2018/10/14.
//

import Foundation
import UIKit
import Kingfisher

public class JXSDLoader: JXPhotoLoader {
    
    public init() {}
    
    public func hasCached(with url: URL?) -> Bool {
        guard let url = url else {
            return false
        }
		return KingfisherManager.shared.cache.isImageCached(forKey: url.cacheKey).cached
    }
    
    public func setImage(on imageView: UIImageView, url: URL?, placeholder: UIImage?, progressBlock: @escaping (Int64, Int64) -> Void, completionHandler: @escaping () -> Void) {
		

		imageView.kf.setImage(with: url, placeholder: placeholder, options: [.transition(ImageTransition.fade(0))], progressBlock: { (receivedSize, totalSize) in
			dispatch_main_async_safe {
				progressBlock(Int64(receivedSize), Int64(totalSize))
			}
		}) { (image, error, type, url) in
			completionHandler()
		}
    }
}
