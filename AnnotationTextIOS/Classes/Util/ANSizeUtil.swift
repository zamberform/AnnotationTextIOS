//
//  ANSizeUtil.swift
//  AnnotationTextIOS
//
//  Created by zamberform on 2019/05/29.
//

open class ANSizeUtil {
    static func labelSizeBy(content: String, font: UIFont?, size: Double) -> CGSize {
        let contentStr = content as NSString
        var resultSize = CGSize.zero
        if let realFont = font {
            resultSize = contentStr.size(withAttributes: [NSAttributedString.Key.font: realFont])
        }
        else {
            
            resultSize = contentStr.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))])
        }
        
        return resultSize
    }
}
