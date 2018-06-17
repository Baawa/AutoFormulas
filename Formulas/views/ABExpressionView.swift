//
//  ABExpressionView.swift
//  Formulas
//
//  Created by Albin Bååw on 2018-06-06.
//  Copyright © 2018 Albin Bååw. All rights reserved.
//

import UIKit

protocol ABExpressionViewDelegate {
	func expressionChanged(view:ABExpressionView)
	func textfieldSelected(tf:ABExpressionTextField)
}

class ABExpressionView: UIView, ABExpressionTextFieldDelegate {
	var views:[UIView] = []
	var textfields:[ABExpressionTextField] = []
	let variables = ["x", "y", "z", "u", "v", "w", "a", "b", "c"]
	var delegate:ABExpressionViewDelegate?
	
	init(frame:CGRect, expression:String){
		super.init(frame:frame)
		let components = expression.split(separator: "@")
		
		var i:Int = 0
		var margin:CGFloat = 0
		var x:CGFloat = 0
		var y:CGFloat = 0
		var yL:CGFloat = ABExpressionTextField.padding.top
		
		// check if @ at start
		if expression.first == "@" {
			let tf = ABExpressionTextField(frame: CGRect(x: x, y: y, width: 10, height: 20), placeholder: variables[i])
			tf.addTarget(self, action: #selector(valueChanged(sender:)), for: .allEditingEvents)
			tf.addTarget(self, action: #selector(stoppedEditing(sender:)), for: .editingDidEnd)
			tf.eDelegate = self
			textfields.append(tf)
			views.append(tf)
			self.addSubview(tf)
			
			x += tf.frame.width + margin
			
			i += 1
		}
		// loop
		let font = ABFonts.expression
		for c in components{
			let size = "\(c)".size(font: font)
			let label = UILabel(frame: CGRect(x: x, y: yL, width: size.width, height: size.height))
			label.font = font
			label.text = "\(c)"
			
			views.append(label)
			
			self.addSubview(label)
			
			x += label.frame.width + margin
			
			if components.last != c{
				let tf = ABExpressionTextField(frame: CGRect(x: x, y: y, width: 10, height: 20), placeholder: variables[i])
				tf.addTarget(self, action: #selector(valueChanged(sender:)), for: .allEditingEvents)
				tf.addTarget(self, action: #selector(stoppedEditing(sender:)), for: .editingDidEnd)
				tf.eDelegate = self
				textfields.append(tf)
				views.append(tf)
				self.addSubview(tf)
				
				x += tf.frame.width + margin
				i += 1
			}
		}
		
		// if @ at end
		if expression.last == "@" {
			let tf = ABExpressionTextField(frame: CGRect(x: x, y: y, width: 10, height: 20), placeholder: variables[i])
			tf.addTarget(self, action: #selector(valueChanged(sender:)), for: .allEditingEvents)
			tf.addTarget(self, action: #selector(stoppedEditing(sender:)), for: .editingDidEnd)
			tf.eDelegate = self
			textfields.append(tf)
			views.append(tf)
			self.addSubview(tf)
			
			x += tf.frame.width + margin
			i += 1
		}
		
		self.frame.size.width = x
		self.frame.size.height = textfields.last!.frame.height
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	internal func resize(source:ABExpressionTextField, diff:CGFloat){
		let index = views.index(where: { (view) -> Bool in
			view == source
		})
		
		if index == nil{
			return
		}
		
		for i in (index!+1)..<views.count{
			views[i].frame.origin.x += diff
		}
		
		self.frame.size.width += diff
		
		self.delegate?.expressionChanged(view: self)
	}
	
	func getValues() -> [Double?]{
		var values:[Double?] = []
		for v in self.textfields{
			values.append(Double(v.text!))
		}
		return values
	}
	
	@objc func valueChanged(sender:ABExpressionTextField){
		let prev = sender.frame.width
		
		//sender.frame.size.width = sender.text!.size(font: sender.font!).width // use for now
		sender.layout(editing: true, width: nil)
		
		let new = sender.frame.width
		
		resize(source: sender, diff: new-prev)
	}
	
	@objc func stoppedEditing(sender:ABExpressionTextField){
		let prev = sender.frame.width
		
		sender.layout(editing: false, width: nil)
		
		let new = sender.frame.width
		
		resize(source: sender, diff: new-prev)
	}
	
	@objc func emptyTextfields() -> [ABExpressionTextField]{
		var result:[ABExpressionTextField] = []
		for tf in self.textfields{
			if tf.isEmpty(){
				result.append(tf)
			}
		}
		
		return result
	}
	
	func startedEditing(tf: ABExpressionTextField) {
		self.delegate?.textfieldSelected(tf: tf)
	}
	
	func setInputView(inputView:UIView?){
		for tf in self.textfields{
			tf.inputView = inputView
		}
	}

}
