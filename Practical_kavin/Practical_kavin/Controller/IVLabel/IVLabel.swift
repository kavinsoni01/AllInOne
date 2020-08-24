//
//  IVLabel.swift
//  Practical_kavin
//
//  Created by Kavin Soni on 22/08/20.
//  Copyright © 2020 kavinMacbook. All rights reserved.
//

import UIKit
enum FontStyle {
    case RobotoBold
    case RobotoLight
    case RobotoRegular
    case RobotoMedium
}

class IVLabel: UILabel {


        var fontStyle:FontStyle = .RobotoRegular
        
        // MARK: PROPERTIES
        public typealias Action = (_ lbl: IVLabel, _ gestureRecognizer: UITapGestureRecognizer) -> Swift.Void
        public private(set) var actionOnTouch: Action?
        open var insets: UIEdgeInsets = .zero
        
        // MARK: INIT
        override open func drawText(in rect: CGRect) {
            super.drawText(in: rect.inset(by: insets))
        }
        
        override open func awakeFromNib() {
            super.awakeFromNib()
            commonInit()
        }
        
        // Override -intrinsicContentSize: for Auto layout code
        override open var intrinsicContentSize: CGSize {
            var contentSize = super.intrinsicContentSize
            contentSize.height += insets.top + insets.bottom
            contentSize.width += insets.left + insets.right
            return contentSize
        }
        
        // Override -sizeThatFits: for Springs & Struts code
        override open func sizeThatFits(_ size: CGSize) -> CGSize {
            var contentSize = super.sizeThatFits(size)
            contentSize.height += insets.top + insets.bottom
            contentSize.width += insets.left + insets.right
            return contentSize
        }

        func leftPadding(value:CGFloat){
            let insets = UIEdgeInsets.init(top: 0, left: value, bottom: 0, right: 5)
            self.drawText(in: self.frame.inset(by: insets))
        }
        // MARK: Tap Action
        
        /// Return you click event on label click
        ///
        /// - Parameter closure: Action
        public func action(_ closure: @escaping Action) {
    //        print("action did set")
            if actionOnTouch == nil {
                let gesture = UITapGestureRecognizer(
                    target: self,
                    action: #selector(self.actionOnTouchUpInside))
                gesture.numberOfTapsRequired = 1
                gesture.numberOfTouchesRequired = 1
                self.addGestureRecognizer(gesture)
                self.isUserInteractionEnabled = true
            }
            self.actionOnTouch = closure
        }
        
        /// UILabel Action
        @objc internal func actionOnTouchUpInside(_ gesture: UITapGestureRecognizer) {
            actionOnTouch?(self, gesture)
        }
        
        func characterSpacing(value:Float){
            let attributedString = NSMutableAttributedString(string: self.text!)
            attributedString.addAttribute(NSAttributedString.Key.kern, value: value, range: NSRange(location: 0, length: attributedString.length))
            self.attributedText = attributedString
        }

        /// Default methords
        private func commonInit() {
            
            switch fontStyle {
                
            case .RobotoBold:
                self.font = UIFont.appFont_RobotoBold(Size: self.font.pointSize)

            case .RobotoRegular:
                self.font = UIFont.appFont_RobotoRegular(Size: self.font.pointSize)

            case .RobotoMedium:
                self.font = UIFont.appFont_RobotoMedium(Size: self.font.pointSize)

            case .RobotoLight:
                self.font = UIFont.appFont_RobotoLight(Size: self.font.pointSize)
                
            }
        }

}
