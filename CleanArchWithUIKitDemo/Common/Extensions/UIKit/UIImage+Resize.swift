//
//  UIImage+Resize.swift
//  CleanArchWithUIKitDemo
//
//  Created by Jill Chang on 2025/3/9.
//

import UIKit

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage {
        let originalSize = size
        let widthRatio = targetSize.width / originalSize.width
        let heightRatio = targetSize.height / originalSize.height
        let scaleRatio = min(widthRatio, heightRatio)

        let newSize = CGSize(
            width: round(originalSize.width * scaleRatio),
            height: round(originalSize.height * scaleRatio)
        )

        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale

        return UIGraphicsImageRenderer(size: newSize, format: format).image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }
    }
}
