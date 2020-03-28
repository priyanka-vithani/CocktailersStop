//
//  UILabelExtensions.swift
//  CookerApp
//
//  Created by Admin on 27/12/17.
//  Copyright © 2017 EL. All rights reserved.
//

import Foundation
import UIKit

public extension UILabel
{
    func addLabelLeftPadding(_ image: UIImage,Text:String)
    {
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: -10, y: -10, width: image.size.width, height: image.size.height)
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        let completeText = NSMutableAttributedString(string: "")
        completeText.append(attachmentString)
        let  textAfterIcon = NSMutableAttributedString(string: " " + Text)
        completeText.append(textAfterIcon)
        self.textAlignment = .left;
        self.attributedText = completeText;
    }
    func applyGradientWith(startColor: UIColor, endColor: UIColor) -> Bool {
        
        var startColorRed:CGFloat = 0
        var startColorGreen:CGFloat = 0
        var startColorBlue:CGFloat = 0
        var startAlpha:CGFloat = 0
        
        if !startColor.getRed(&startColorRed, green: &startColorGreen, blue: &startColorBlue, alpha: &startAlpha) {
            return false
        }
        
        var endColorRed:CGFloat = 0
        var endColorGreen:CGFloat = 0
        var endColorBlue:CGFloat = 0
        var endAlpha:CGFloat = 0
        
        if !endColor.getRed(&endColorRed, green: &endColorGreen, blue: &endColorBlue, alpha: &endAlpha) {
            return false
        }
        
        let gradientText = self.text ?? ""
        
        let name:String = NSAttributedString.Key.font.rawValue
        let textSize: CGSize = gradientText.size(withAttributes: [NSAttributedString.Key(rawValue: name):self.font])
        let width:CGFloat = textSize.width
        let height:CGFloat = textSize.height
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return false
        }
        
        UIGraphicsPushContext(context)
        
        let glossGradient:CGGradient?
        let rgbColorspace:CGColorSpace?
        let num_locations:size_t = 2
        let locations:[CGFloat] = [ 0.0, 1.0 ]
        let components:[CGFloat] = [startColorRed, startColorGreen, startColorBlue, startAlpha, endColorRed, endColorGreen, endColorBlue, endAlpha]
        rgbColorspace = CGColorSpaceCreateDeviceRGB()
        glossGradient = CGGradient(colorSpace: rgbColorspace!, colorComponents: components, locations: locations, count: num_locations)
        let topCenter = CGPoint.zero
        let bottomCenter = CGPoint(x: 0, y: textSize.height)
        context.drawLinearGradient(glossGradient!, start: topCenter, end: bottomCenter, options: CGGradientDrawingOptions.drawsBeforeStartLocation)
        
        UIGraphicsPopContext()
        
        guard let gradientImage = UIGraphicsGetImageFromCurrentImageContext() else {
            UIGraphicsEndImageContext()
            return false
        }
        
        UIGraphicsEndImageContext()
        
        self.textColor = UIColor(patternImage: gradientImage)
        
        return true
    }
}



extension UILabel {
    func sizeToFitHeight() {
        let tempLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        tempLabel.numberOfLines = numberOfLines
        tempLabel.lineBreakMode = lineBreakMode
        tempLabel.font = font
        tempLabel.text = text
        tempLabel.sizeToFit()
        frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: tempLabel.frame.height)
    }
}


