//
//  ABExpressionTextField.swift
//  Formulas
//
//  Created by Albin Bååw on 2018-06-06.
//  Copyright © 2018 Albin Bååw. All rights reserved.
//

import UIKit

protocol ABExpressionTextFieldDelegate{
	func startedEditing(tf:ABExpressionTextField)
}

class ABExpressionTextField: UITextField {

	internal var placeholderString = ""
	internal var eDelegate:ABExpressionTextFieldDelegate?
	
	init(frame:CGRect, placeholder:String) {
		super.init(frame:frame)
		
		self.placeholderString = placeholder
		self.font = ABFonts.expression
		
		self.layout(editing: false, width: nil)
		
		self.addTarget(self, action: #selector(startedEditing), for: .editingDidBegin)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func isEmpty() -> Bool{
		return self.text == "" || self.text == placeholderString || self.text == nil
	}
	
	func layout(editing:Bool, width:CGFloat?){
		if (isEmpty()) && !editing{
			self.text = placeholderString
			self.backgroundColor = ABColors.themeSaturated
			self.textColor = ABColors.theme
		} else{
			self.backgroundColor = ABColors.calcBg
			self.textColor = .black
		}
		
		let size = self.text!.size(font: self.font!)
		self.frame.size.height = size.height + ABExpressionTextField.padding.top + ABExpressionTextField.padding.bottom
		if width != nil{
			self.frame.size.width = width!
		} else{
			self.frame.size.width = size.width + ABExpressionTextField.padding.left + ABExpressionTextField.padding.right
		}
		
		self.setCornerRadius(self.frame.height/2)
	}
	
	@objc func startedEditing(){
		if isEmpty(){
			self.text = ""
		}
		self.selectAll(nil)
		self.eDelegate?.startedEditing(tf: self)
	}
	
	static let paddingEmpty = UIEdgeInsets(top: 1, left: 10, bottom: 1, right: 10)
	static let paddingFilled = UIEdgeInsets.zero
	static var padding = ABExpressionTextField.paddingEmpty
	override open func textRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, ABExpressionTextField.padding)
	}
	
	override open func editingRect(forBounds bounds: CGRect) -> CGRect {
		return UIEdgeInsetsInsetRect(bounds, ABExpressionTextField.padding)
	}
	
}
