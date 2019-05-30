//
//  AnnotationTextView.swift
//  AnnotationTextIOS
//
//  Created by zamberform on 2019/05/29.
//

@IBDesignable
open class AnnotationTextView : UIView {
    @IBInspectable
    public var isShowAnnotation: Bool = true
    @IBInspectable
    public var splitStr: String? = nil {
        willSet(newValue) {
            if let splitUnit = newValue, let contentTxt = text, let annotationTxt = annotationText {
                contentList = contentTxt.components(separatedBy: splitUnit)
                annotationList = annotationTxt.components(separatedBy: splitUnit)
            }
            
            try? createTextsView()
        }
    }
    @IBInspectable
    public var lineSpace: Double = 0
    @IBInspectable
    public var annotationSpace: Double = 0
    @IBInspectable
    public var annotationRadio: Double = 0.8 {
        willSet(newValue) {
            if !newValue.isEqual(to: .zero), let fontName1 = textFontName, let fontName2 = annotationFontName  {
                textFont = UIFont(name: fontName1, size: CGFloat(textSize))
                annotationFont = UIFont(name: fontName2, size: CGFloat(textSize * annotationRadio))
            }
        }
    }
    
    @IBInspectable
    public var textSize: Double = Double(UIFont.systemFontSize)
    @IBInspectable
    public var textColor: UIColor = UIColor.black
    @IBInspectable
    public var textFontName: String? = nil {
        willSet(newValue) {
            if textSize.isEqual(to: .zero) {
                textSize = 50
            }
            if let fontName = newValue {
                textFont = UIFont(name: fontName, size: CGFloat(textSize))
            }
        }
    }
    
    @IBInspectable
    public var annotationColor: UIColor = UIColor.gray
    @IBInspectable
    public var annotationFontName: String? = nil {
        willSet(newValue) {
            if annotationRadio.isEqual(to: .zero) {
                annotationRadio = 0.8
            }
            if let fontName = newValue {
                annotationFont = UIFont(name: fontName, size: CGFloat(textSize * annotationRadio))
            }
        }
    }
    
    @IBInspectable
    public var text: String? = nil {
        willSet(newValue) {
            if let splitUnit = splitStr, let contentTxt = newValue {
                contentList = contentTxt.components(separatedBy: splitUnit)
            }
            
            try? createTextsView()
        }
    }
    @IBInspectable
    public var annotationText: String? = nil {
        willSet(newValue) {
            if let splitUnit = splitStr, let annotationText = newValue {
                annotationList = annotationText.components(separatedBy: splitUnit)
            }
            
            try? createTextsView()
        }
    }
    
    private var annotationFont: UIFont?
    private var textFont: UIFont?
    
    private var contentList: Array<String>?
    private var annotationList: Array<String>?
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience public init() {
        self.init(frame: CGRect.zero)
    }
}

extension AnnotationTextView {
    public func setTextFont(font: UIFont) {
        textFont = font
        reload()
    }
    
    public func setAnnotationTxtFont(font: UIFont) {
        annotationFont = font
        reload()
    }
}

// inner funcs
extension AnnotationTextView {
    private func setup() {
        
    }
    
    private func reload() {
        subviews.forEach({ $0.removeFromSuperview() })
        try? createTextsView()
    }
    
    private func createTextsView() throws {
        if let contentArray = contentList, let annotationArray = annotationList {
            if isShowAnnotation {
                // check the length
                if contentArray.count != annotationArray.count && !isShowAnnotation {
                    throw ANError.size
                }
            }
            var sumWidth: Double = 0
            var viewY: Double = 0
            contentArray.enumerated().forEach({ (arg0) in
                let (index, content) = arg0
                
                let currentSize = ANSizeUtil.labelSizeBy(content: content, font: textFont, size: textSize)
                var maxWidth = currentSize.width
                
                let contentLabel = UILabel()
                contentLabel.textColor = textColor
                if let font = textFont {
                    contentLabel.font = font
                }
                else {
                    contentLabel.font = UIFont.systemFont(ofSize: CGFloat(textSize))
                }
                
                contentLabel.textAlignment = .center
                contentLabel.text = content
                contentLabel.sizeToFit()
                
                addSubview(contentLabel)
                
                var currentANSize = CGSize.zero
                if isShowAnnotation {
                    let anTxt = annotationArray[index]
                    currentANSize = ANSizeUtil.labelSizeBy(content: anTxt, font: annotationFont, size: textSize * annotationRadio)
                    
                    if currentANSize.width > maxWidth {
                        maxWidth = currentANSize.width
                    }
                    
                    let aNLabel = UILabel()
                    aNLabel.textColor = annotationColor
                    if annotationFont != nil {
                        aNLabel.font = annotationFont
                    }
                    else {
                        aNLabel.font = UIFont.systemFont(ofSize: CGFloat(textSize * annotationRadio))
                    }
                    aNLabel.textAlignment = .center
                    aNLabel.text = anTxt
                    aNLabel.sizeToFit()
                    
                    aNLabel.frame = CGRect(x: sumWidth, y: viewY - Double(currentANSize.height) - annotationSpace, width: Double(maxWidth), height: Double(currentANSize.height))
                    addSubview(aNLabel)
                }
                contentLabel.frame = CGRect(x: sumWidth, y: viewY, width: Double(maxWidth), height: Double(currentSize.height))
                
                sumWidth += Double(maxWidth)
                
                if (Double(frame.size.width) <= sumWidth) {
                    viewY += lineSpace + Double(currentSize.height + currentANSize.height)
                    sumWidth = 0
                }
            })
        }
        else {
            throw ANError.none
        }
        
    }
    
}

