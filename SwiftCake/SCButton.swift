//
//  SKButton.swift
//  SwiftCake
//
//  Created by Dominik Majda on 23.02.2017.
//  Copyright © 2017 Dominik Majda. All rights reserved.
//

import UIKit

//@IBDesignable
open class SCButton: UIButton, SCRoundedBorderedView {
    
    @IBInspectable open var reversed: Bool = false {
        didSet {
            if reversed {
                transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
                imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
            }
        }
    }

    @IBInspectable open var cornerRadius: CGFloat = 0.0 {
        didSet {
            updateCornerRadius(with: cornerRadius)
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 0.0 {
        didSet {
            updateBorderWidth(with: borderWidth)
        }
    }
    
    @IBInspectable open var borderColor: UIColor = UIColor.clear {
        didSet {
            updateBorderColor(with: borderColor)
        }
    }
    
    @IBInspectable open var backgroundColorSelected: UIColor = UIColor.clear
    
    /// In this value we save original background color so we can restore it
    private var _orginalBackgroundColor: UIColor?
    
    @IBInspectable open var borderColorSelected: UIColor = UIColor.clear
    
    open override var isSelected: Bool {
        didSet {
            if isSelected {
                updateBorderColor(with: borderColorSelected)
                
                if _orginalBackgroundColor == nil {
                    _orginalBackgroundColor = backgroundColor
                }
                
                backgroundColor = backgroundColorSelected
            } else {
                updateBorderColor(with: borderColor)
                backgroundColor = _orginalBackgroundColor
            }
        }
    }
    
}

open class SCCheckbox: SCButton {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        addSelectTarget()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSelectTarget()
    }
    
    private func addSelectTarget() {
        addTarget(self, action: #selector(reverse), for: .touchUpInside)
    }
    
    @objc func reverse() {
        isSelected = !isSelected
        sendActions(for: .valueChanged)
    }
}

