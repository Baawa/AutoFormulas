//
//  ABConversionView.swift
//  Formulas
//
//  Created by Albin Bååw on 2018-06-07.
//  Copyright © 2018 Albin Bååw. All rights reserved.
//

import UIKit

protocol ABConversionViewDelegate{
	func value1Changed(val:Double)
	func value2Changed(val:Double)
	func switchClicked()
	
	func textfieldSelected(tf:ABExpressionTextField)
}

class ABConversionView: UIView, ABExpressionTextFieldDelegate {
	internal var value1:ABExpressionTextField!
	internal var value2:ABExpressionTextField!
	internal var switchBtn:UIButton!
	
	internal var tfWidth:CGFloat = 0
	
	var textfields:[ABExpressionTextField] = []
	
	var delegate:ABConversionViewDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.backgroundColor = ABColors.calcField
		
		var margin:CGFloat = 20
		var x:CGFloat = margin
		var y:CGFloat = margin
		
		var btnWidth:CGFloat = 30
		var btnHeight:CGFloat = 22.2
		
		tfWidth = (self.frame.width - (4*margin + btnWidth))/2
		
		value1 = ABExpressionTextField(frame: CGRect(x: x, y: y, width: tfWidth, height: 20), placeholder: "From")
		value1.addTarget(self, action: #selector(valueChanged(sender:)), for: .allEditingEvents)
		value1.addTarget(self, action: #selector(stoppedEditing(sender:)), for: .editingDidEnd)
		value1.eDelegate = self
		value1.layout(editing: false, width: tfWidth)
		value1.textAlignment = .center
		self.addSubview(value1)
		
		textfields.append(value1)
		
		x += value1.frame.width + margin
		
		switchBtn = UIButton(frame: CGRect(x: x, y: y + (value1.frame.height/2-btnHeight/2), width: btnWidth, height: btnHeight))
		switchBtn.setImage(#imageLiteral(resourceName: "switchIcon"), for: .normal)
		switchBtn.tintColor = ABColors.theme
		switchBtn.addTarget(self, action: #selector(switchFields), for: .touchUpInside)
		self.addSubview(switchBtn)
		
		x += switchBtn.frame.width + margin
		
		value2 = ABExpressionTextField(frame: CGRect(x: x, y: y, width: tfWidth, height: 20), placeholder: "To")
		value2.addTarget(self, action: #selector(valueChanged(sender:)), for: .allEditingEvents)
		value2.addTarget(self, action: #selector(stoppedEditing(sender:)), for: .editingDidEnd)
		value2.eDelegate = self
		value2.layout(editing: false, width: tfWidth)
		value2.textAlignment = .center
		self.addSubview(value2)
		
		textfields.append(value2)
		
		self.frame.size.height = value1.frame.height + 2*margin
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	@objc func switchFields(){
		let val1 = self.value1.text
		let val2 = self.value2.text
		let empty1 = self.value1.isEmpty()
		let empty2 = self.value2.isEmpty()
		
		self.value1.text = ""
		if empty2{
			self.value1.text = ""
			self.value1.layout(editing: false, width: tfWidth)
		} else{
			self.value1.text = val2!
			self.value1.layout(editing: true, width: tfWidth)
		}
		
		if empty1{
			self.value2.text = ""
			self.value2.layout(editing: false, width: tfWidth)
		} else{
			self.value2.text = val1!
			self.value2.layout(editing: true, width: tfWidth)
		}
		
		self.delegate?.switchClicked()
	}
	
	@objc func valueChanged(sender:ABExpressionTextField){
		let prev = sender.frame.width

		sender.layout(editing: true, width: tfWidth)
	}
	
	@objc func stoppedEditing(sender:ABExpressionTextField){
		let prev = sender.frame.width
		
		sender.layout(editing: false, width: tfWidth)
	}
	
	func getValues() -> [Double?]{
		var values:[Double?] = []
		for v in self.textfields{
			values.append(Double(v.text!))
		}
		return values
	}
	
	func emptyTextfields() -> [ABExpressionTextField]{
		var result:[ABExpressionTextField] = []
		
		if value1.isEmpty(){
			result.append(value1)
		}
		if value2.isEmpty(){
			result.append(value2)
		}
		
		return result
	}
	
	func startedEditing(tf: ABExpressionTextField) {
		self.delegate?.textfieldSelected(tf: tf)
	}
	
	func setInputView(inputView:UIView?){
		value1.inputView = inputView
		value2.inputView = inputView
	}
	
}
