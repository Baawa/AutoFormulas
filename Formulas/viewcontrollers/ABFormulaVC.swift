//
//  ViewController.swift
//  Formulas
//
//  Created by Albin Bååw on 2017-04-24.
//  Copyright © 2017 Albin Bååw. All rights reserved.
//

import UIKit

class ABFormulaVC: UIViewController, ABExpressionViewDelegate, ABCalculatorViewDelegate {
	var formula:ABFormula!{
		didSet{
			layout()
		}
	}
	
	internal var ev:ABExpressionView!
	internal var descV:UITextView!
	internal var calc:ABCalculatorView!
	
	internal var evHolder:UIScrollView!
	
	var navbarHeight:CGFloat?
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	internal func layout(){
		self.title = self.formula.name
		
		var y:CGFloat = 100
		if self.navbarHeight != nil{
			y = self.navbarHeight!
		}
		
		var margin:CGFloat = 20
		
		ev = ABExpressionView(frame: CGRect(x: 0, y: margin, width: 100, height: 100), expression: self.formula.expression)
		ev.delegate = self
		
		evHolder = UIScrollView(frame: CGRect(x: 0, y: y, width: self.view.frame.width, height: ev.frame.height+2*margin))
		evHolder.backgroundColor = ABColors.calcField
		
		self.view.addSubview(evHolder)
		
		evHolder.addSubview(ev)
		evHolder.bringSubview(toFront: ev)
		expressionChanged(view: ev)
		
		y += evHolder.frame.height + margin
		
		descV = UITextView(frame: CGRect(x: margin, y: y, width: self.view.frame.width-2*margin, height: self.view.frame.height - y))
		descV.isEditable = false
		descV.font = ABFonts.expression
		descV.text = self.formula.desc
		descV.contentInset = UIEdgeInsets.zero
		
		self.view.addSubview(descV)
		
		calc = ABCalculatorView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
		calc.frame.origin.y = self.view.frame.height - calc.frame.height
		calc.delegate = self
		//self.view.addSubview(calc)
		
		ev.setInputView(inputView: calc)
	}
	
	func expressionChanged(view: ABExpressionView) {
		var margin:CGFloat = 20
		var width:CGFloat = view.frame.width+margin
		if width > self.view.frame.width {
			view.frame.origin.x = margin
			evHolder.contentSize.width = width+margin
			scrollToFirstResponder()
		} else{
			view.frame.origin.x = evHolder.frame.width - width
			evHolder.contentSize.width = self.view.frame.width
		}
	}
	
	func scrollToFirstResponder(){
		if evHolder.contentSize.width > self.view.frame.width{
			if self.view.firstResponder != nil{
				let fr = self.view.firstResponder!
				var offset:CGFloat = fr.frame.origin.x + fr.frame.width
				let max = evHolder.contentSize.width - self.view.frame.width
				
				if offset > max{
					offset = max
				}
				
				let center = CGPoint(x: offset, y: 0)
				evHolder.setContentOffset(center, animated: false)
			}
		}
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
			
			if let index = ev.textfields.index(of: tf){
				if index > 0{
					ev.textfields[index - 1].becomeFirstResponder()
					setPrevNext(tf: ev.textfields[index - 1])
				}
			}
		} else{
			ev.textfields.first?.becomeFirstResponder()
			if ev.textfields.count > 0{
				setPrevNext(tf: ev.textfields.first!)
			}
		}
		scrollToFirstResponder()
	}
	
	func nextClicked() {
		if view.firstResponder is ABExpressionTextField{
			let tf = view.firstResponder! as! ABExpressionTextField
			
			if let index = ev.textfields.index(of: tf){
				if index + 1 < ev.textfields.count{
					ev.textfields[index + 1].becomeFirstResponder()
					setPrevNext(tf: ev.textfields[index + 1])
				}
			}
		} else{
			ev.textfields.first?.becomeFirstResponder()
			ev.textfields.first?.becomeFirstResponder()
			if ev.textfields.count > 0{
				setPrevNext(tf: ev.textfields.first!)
			}
		}
		scrollToFirstResponder()
	}
	
	func numberClicked(num: Int) {
		appendTextField(val: "\(num)")
	}
	
	func punctuationClicked() {
		appendTextField(val: ".")
	}
	
	func doneClicked() {
		let tfs = ev.emptyTextfields()
		if tfs.count == 1{
			let val = self.formula.calculate(values: ev.getValues())
			tfs[0].text = ""
			tfs[0].insertText("\(val.roundTo(amountOfDigits: 2))")
		} else if tfs.count == 0{
			// tf isn't the last one (the one after equal sign) we want to calculate this one if there is no empty tfs.
			if view.firstResponder is ABExpressionTextField{
				let tf = view.firstResponder! as! ABExpressionTextField
				if tf != ev.textfields.last{
					var values = ev.getValues()
					values[values.count-1] = nil
					let val = self.formula.calculate(values: values)
					ev.textfields.last?.text = ""
					ev.textfields.last?.insertText("\(val.roundTo(amountOfDigits: 2))")
				}
			}
		} else{
			tfs[0].becomeFirstResponder()
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
		calc.isPrevEnabled = tf != ev.textfields.first
		calc.isNextEnabled = tf != ev.textfields.last
	}
	
	func textfieldSelected(tf: ABExpressionTextField) {
		setPrevNext(tf: tf)
		animateDescription(expand: true)
	}
	
	func animateDescription(expand:Bool){
		if expand{
			UIView.animate(withDuration: 0.2, animations: {
				self.descV.frame.size.height = self.view.frame.height - (self.descV.frame.origin.y + self.calc.frame.height)
			}) { (flag) in
				// scroll in descV?
			}
		} else{
			UIView.animate(withDuration: 0.2, animations: {
				self.descV.frame.size.height = self.view.frame.height - self.descV.frame.origin.y
			}) { (flag) in
				// scroll in descV?
			}
		}
	}
}

