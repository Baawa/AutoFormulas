//
//  ABConversionVC.swift
//  Formulas
//
//  Created by Albin Bååw on 2018-06-07.
//  Copyright © 2018 Albin Bååw. All rights reserved.
//

import UIKit

class ABConversionVC: UIViewController, ABCalculatorViewDelegate, ABConversionViewDelegate, UITableViewDelegate, UITableViewDataSource {
	
	internal var cv:ABConversionView!
	internal var calc:ABCalculatorView!
	
	internal var types1:UITableView!
	internal var types2:UITableView!
	
	var formula:ABConversionFormula!{
		didSet{
			layout()
		}
	}
	
	var navbarHeight:CGFloat?
	
	internal let reuseId:String = "cell"
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	internal func layout(){
		self.title = formula.name
		
		var y:CGFloat = 100
		if self.navbarHeight != nil{
			y = self.navbarHeight!
		}
		var margin:CGFloat = 20
		
		cv = ABConversionView(frame: CGRect(x: 0, y: y, width: self.view.frame.width, height: 100))
		cv.delegate = self
		self.view.addSubview(cv)
		
		calc = ABCalculatorView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
		calc.frame.origin.y = self.view.frame.height - calc.frame.height
		calc.delegate = self
		
		//self.view.addSubview(calc)
		cv.setInputView(inputView: calc)
		
		y = cv.frame.height + cv.frame.origin.y
		let height:CGFloat = calc.frame.origin.y - y
		let width:CGFloat = self.view.frame.width/2
		
		types1 = UITableView(frame: CGRect(x: 0, y: y, width: width, height: height))
		types1.delegate = self
		types1.dataSource = self
		types1.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
		self.view.addSubview(types1)
		
		types2 = UITableView(frame: CGRect(x: width, y: y, width: width, height: height))
		types2.delegate = self
		types2.dataSource = self
		types2.register(UITableViewCell.self, forCellReuseIdentifier: reuseId)
		self.view.addSubview(types2)
		
		type1 = self.formula.conversions[0]
		types1.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
		
		type2 = self.formula.conversions[1]
		types2.selectRow(at: IndexPath(row: 1, section: 0), animated: false, scrollPosition: .none)
		
		nextClicked() //show keyboard
	}
	
	func appendTextField(val:String){
		if view.firstResponder is UITextField{
			let tf = view.firstResponder! as! UITextField
			if val == "."{
				if tf.text?.contains(val) == false{
					tf.insertText(val)
				}
			} else{
				tf.insertText(val)
			}
		}
	}
	
	func prevClicked() {
		if view.firstResponder is ABExpressionTextField{
			let tf = view.firstResponder! as! ABExpressionTextField
			
			if let index = cv.textfields.index(of: tf){
				if index > 0{
					cv.textfields[index - 1].becomeFirstResponder()
					setPrevNext(tf: cv.textfields[index - 1])
				}
			}
		} else{
			cv.textfields.first?.becomeFirstResponder()
			if cv.textfields.count > 0{
				setPrevNext(tf: cv.textfields.first!)
			}
		}
	}
	
	func nextClicked() {
		if view.firstResponder is ABExpressionTextField{
			let tf = view.firstResponder! as! ABExpressionTextField
			
			if let index = cv.textfields.index(of: tf){
				if index + 1 < cv.textfields.count{
					cv.textfields[index + 1].becomeFirstResponder()
					setPrevNext(tf: cv.textfields[index + 1])
				}
			}
		} else{
			cv.textfields.first?.becomeFirstResponder()
			cv.textfields.first?.becomeFirstResponder()
			if cv.textfields.count > 0{
				setPrevNext(tf: cv.textfields.first!)
			}
		}
	}
	
	func numberClicked(num: Int) {
		appendTextField(val: "\(num)")
	}
	
	func punctuationClicked() {
		appendTextField(val: ".")
	}
	
	internal var type1:ABConversionFormula.ConversionItem!
	internal var type2:ABConversionFormula.ConversionItem!
	func doneClicked() {
		if (cv.value1.isEmpty() && !cv.value2.isEmpty()) || (view.firstResponder == cv.value2 && !cv.value2.isEmpty()){
			let val = self.formula.calculate(from: type2, to: type1, value: Double(cv.value2.text!))
			cv.value1.text = ""
			cv.value1.insertText("\(val.roundTo(amountOfDigits: 4))")
		} else if !cv.value1.isEmpty(){
			let val = self.formula.calculate(from: type1, to: type2, value: Double(cv.value1.text!))
			cv.value2.text = ""
			cv.value2.insertText("\(val.roundTo(amountOfDigits: 4))")
		} else{
			cv.value1.becomeFirstResponder()
		}
	}
	
	func deleteClicked() {
		if view.firstResponder is UITextField{
			let tf = view.firstResponder! as! UITextField
			if tf.text != "" && tf.text != nil{
				tf.replace(tf.textRange(from: tf.position(from: tf.endOfDocument, offset: -1)!, to: tf.endOfDocument)!, withText: "")
			}
		}
	}
	
	func setPrevNext(tf: ABExpressionTextField){
		calc.isPrevEnabled = tf != cv.textfields.first
		calc.isNextEnabled = tf != cv.textfields.last
	}
	
	func textfieldSelected(tf: ABExpressionTextField) {
		setPrevNext(tf: tf)
	}
	
	func value1Changed(val: Double) {
		//
	}
	
	func value2Changed(val: Double) {
		//
	}
	
	func switchClicked() {
		let tmp = types2.indexPathForSelectedRow
		types2.selectRow(at: types1.indexPathForSelectedRow, animated: false, scrollPosition: .none)
		types1.selectRow(at: tmp, animated: false, scrollPosition: .none)
	}
	
	// MARK: UITableView
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if tableView == types1{
			self.type1 = self.formula.conversions[indexPath.row]
		} else if tableView == types2{
			self.type2 = self.formula.conversions[indexPath.row]
		}
		doneClicked()
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.formula.conversions.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCell(withIdentifier: reuseId)
		cell?.textLabel?.text = self.formula.conversions[indexPath.row].name
		
		return cell!
	}
	
    

}
