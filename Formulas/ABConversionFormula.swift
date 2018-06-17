//
//  ABConversionFormula.swift
//  Formulas
//
//  Created by Albin Bååw on 2018-06-06.
//  Copyright © 2018 Albin Bååw. All rights reserved.
//

import UIKit

class ABConversionFormula: ABFormula {
	var conversions:[ConversionItem] = [] // e.g. [("gram",1.0), ("kilogram",1000.0)]
	
	init(name:String, conversions:[ConversionItem]){
		super.init(name: name, desc: "", type: .conversion, expression: "") { (d) -> Double in
			return 0
		}
		self.conversions = conversions
	}
	
	override init(name: String, desc: String, type: FormulaType, expression: String, formula: @escaping ([Double?]) -> Double) {
		fatalError("function not implemented")
	}
	
	func calculate(from:ConversionItem, to:ConversionItem, value:Double?) -> Double{
		if value != nil{
			return (from.value/to.value)*value!
		}
		return 0
	}
	
	override func calculate(values: [Double?]) -> Double {
		return 0
	}
	
	struct ConversionItem{
		let name:String
		let value:Double
	}
}
