//
//  UIButtonExtension.swift
//  CodeChallenge
//
//  Created by Sebastien Audeon on 5/4/19.
//  Copyright © 2019 LuckyDay. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setBackgroundColor(_ color: UIColor) {
        
        self.clipsToBounds = true
        
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .highlighted)
        self.setTitleColor(.white, for: .selected)
        
        self.setBackgroundImage(UIImage.image(with: color), for: .normal)
        self.setBackgroundImage(UIImage.image(with: color), for: .highlighted)
        self.setBackgroundImage(UIImage.image(with: color), for: .selected)
        
    }
    
}

extension UIImage {
    
    class func image(with color: UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        color.setFill()
        UIRectFill(rect)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
        
    }
    
}
