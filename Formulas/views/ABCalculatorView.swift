//
//  ABCalculatorView.swift
//  Formulas
//
//  Created by Albin Bååw on 2018-06-06.
//  Copyright © 2018 Albin Bååw. All rights reserved.
//

import UIKit

protocol ABCalculatorViewDelegate{
	func prevClicked()
	func nextClicked()
	func numberClicked(num:Int)
	func punctuationClicked()
	func doneClicked()
	func deleteClicked()
}


class ABCalculatorView: UIView {
	var isPrevEnabled:Bool = true{
		didSet{
			prevBtn.isEnabled = isPrevEnabled
		}
	}
	var isNextEnabled:Bool = true{
		didSet{
			nextBtn.isEnabled = isNextEnabled
		}
	}
	var delegate:ABCalculatorViewDelegate?
	
	internal var prevBtn:UIButton!
	internal var nextBtn:UIButton!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		layout()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	internal func layout(){
		self.backgroundColor = ABColors.calcBg
		
		var margin:CGFloat = 10
		var x:CGFloat = margin
		var y:CGFloat = margin
		
		var size = CGSize(width: 8, height: 20)
		
		prevBtn = UIButton(frame: CGRect(x: x, y: y, width: size.width, height: size.height))
		prevBtn.setImage(#imageLiteral(resourceName: "arrowLeft"), for: .normal)
		prevBtn.tintColor = ABColors.theme
		prevBtn.addTarget(self, action: #selector(prevClicked), for: .touchUpInside)
		
		self.addSubview(prevBtn)
		
		x += size.width + margin*2
		
		nextBtn = UIButton(frame: CGRect(x: x, y: y, width: size.width, height: size.height))
		nextBtn.setImage(#imageLiteral(resourceName: "arrowRight"), for: .normal)
		nextBtn.tintColor = ABColors.theme
		nextBtn.addTarget(self, action: #selector(nextClicked), for: .touchUpInside)
		
		self.addSubview(nextBtn)
		
		size = CGSize(width: 28, height: 20)
		
		x = self.frame.width - margin - size.width
		
		let deleteBtn = UIButton(frame: CGRect(x: x, y: y, width: size.width, height: size.height))
		deleteBtn.setImage(#imageLiteral(resourceName: "deleteBtn"), for: .normal)
		deleteBtn.tintColor = ABColors.theme
		deleteBtn.addTarget(self, action: #selector(deleteClicked), for: .touchUpInside)
		
		self.addSubview(deleteBtn)
		
		y += deleteBtn.frame.height + margin
		x = 0
		
		let height:CGFloat = 80
		let width:CGFloat = self.frame.width/3
		
		for i in 1..<10{
			if x >= self.frame.width{
				x = 0
				y += height
			}
			
			let btn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
			btn.setTitle("\(i)", for: .normal)
			btn.setTitleColor(ABColors.calcSeparator, for: .normal)
			btn.backgroundColor = .clear
			
			btn.tag = i
			btn.addTarget(self, action: #selector(numClicked(sender:)), for: .touchUpInside)
			
			self.addSubview(btn)
			
			x += width
		}
		
		x = 0
		y += height
		
		let pBtn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
		pBtn.setTitle(".", for: .normal)
		pBtn.setTitleColor(ABColors.calcSeparator, for: .normal)
		pBtn.backgroundColor = .clear
		
		pBtn.addTarget(self, action: #selector(punctuationClicked), for: .touchUpInside)
		
		self.addSubview(pBtn)
		
		x += width
		
		let zBtn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
		zBtn.setTitle("\(0)", for: .normal)
		zBtn.setTitleColor(ABColors.calcSeparator, for: .normal)
		zBtn.backgroundColor = .clear
		
		zBtn.tag = 0
		zBtn.addTarget(self, action: #selector(numClicked(sender:)), for: .touchUpInside)
		
		self.addSubview(zBtn)
		
		x += width
		
		let dBtn = UIButton(frame: CGRect(x: x, y: y, width: width, height: height))
		dBtn.setTitle("Done", for: .normal)
		dBtn.setTitleColor(ABColors.theme, for: .normal)
		dBtn.backgroundColor = .clear
		
		dBtn.addTarget(self, action: #selector(doneClicked), for: .touchUpInside)
		
		self.addSubview(dBtn)
		
		x = 0
		y += height
		
		self.frame.size.height = y
	}
	
	@objc func prevClicked(){
		delegate?.prevClicked()
	}
	
	@objc func nextClicked(){
		delegate?.nextClicked()
	}
	
	@objc func numClicked(sender:UIButton){
		delegate?.numberClicked(num: sender.tag)
	}
	
	@objc func punctuationClicked(){
		delegate?.punctuationClicked()
	}
	
	@objc func doneClicked(){
		delegate?.doneClicked()
	}
	
	@objc func deleteClicked(){
		delegate?.deleteClicked()
	}

}
