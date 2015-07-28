//
//  ImageUtil.swift
//  RatingSystem
//
//  Created by Daniel Honies on 27.07.15.
//  Copyright © 2015 Daniel Honies. All rights reserved.
//

import UIKit

class ImageUtil: NSObject {
    
    static func cropToLength(image originalImage: UIImage, length: CGFloat) -> UIImage {
        let contextImage: UIImage = UIImage(CGImage: originalImage.CGImage!)
        let contextSize: CGSize = contextImage.size
        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat
        posX = 0
        posY = 0//((contextSize.height - contextSize.width) / 2)
        width = contextSize.width * length
        height = contextSize.height
        let rect: CGRect = CGRectMake(posX, posY, width, height)
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        let image: UIImage = UIImage(CGImage: imageRef, scale: originalImage.scale, orientation: originalImage.imageOrientation)
        
        return image
    }
    
}