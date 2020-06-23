//
//  UIImageView+.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/23.
//  Copyright © 2020 yuoku. All rights reserved.
//

import Nuke
import UIKit

// MARK: - Load image from URL
extension UIImageView {
    func loadImage(urlString: String?, loadingBackgroundColor: UIColor? = nil) {
        guard let urlString = urlString else {
            return
        }
        guard !urlString.isEmpty else {
            return
        }

        ImagePipeline.Configuration.isAnimatedImageDataEnabled = true
        let prevBackgroundColor = self.backgroundColor
        self.backgroundColor = loadingBackgroundColor

        let url = urlString.toURL()
        let imageRequest = ImageRequest(url: url)
        let options = ImageLoadingOptions(transition: .fadeIn(duration: 0.3))
        Nuke.loadImage(with: imageRequest, options: options, into: self) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                print("Image load error:\(error)")
            }
            self.backgroundColor = prevBackgroundColor
        }
    }
}
