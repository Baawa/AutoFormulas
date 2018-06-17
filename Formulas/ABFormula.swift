//
//  ABFormula.swift
//  Formulas
//
//  Created by Albin Bååw on 2017-04-24.
//  Copyright © 2017 Albin Bååw. All rights reserved.
//

import UIKit

class ABFormula: NSObject {
    var name:String!
    var desc:String!
	var type:FormulaType = .none
    var expression:String = ""
    var formula:(_ :[Double?])->Double!
    
	init(name:String, desc:String, type:FormulaType, expression:String, formula:@escaping (_ :[Double?])->Double) {
        self.name = name
        self.desc = desc
		self.type = type
        self.expression = expression
        self.formula = formula
    }
    
    func calculate(values:[Double?]) -> Double{
		var val = self.formula(values)
		if val?.isNaN == true || val?.isSignalingNaN == true || val == nil{
			val = 0
		} else if val?.isInfinite == true{
			val = 999999999999.99
		}
        return val!
    }
	
	func getIcon() -> UIImage{
		var icon:UIImage = UIImage()
		switch self.type {
		case .math:
			icon = #imageLiteral(resourceName: "mathIcon")
			break
		case .physics:
			icon = #imageLiteral(resourceName: "physicsIcon")
			break
		case .chemistry:
			icon = #imageLiteral(resourceName: "chemistryIcon")
			break
		case .conversion:
			icon = #imageLiteral(resourceName: "conversionIcon")
			break
		default:
			break
		}
		
		return icon
	}
	
	func getTypeAndColor() -> (String, UIColor){
		var tc:(String, UIColor) = ("", .white)
		switch self.type {
		case .math:
			tc = ("MATH", ABColors.theme)
			break
		case .physics:
			tc = ("PHYSICS", ABColors.theme)
			break
		case .chemistry:
			tc = ("CHEMISTRY", ABColors.theme)
			break
		case .conversion:
			tc = ("CONVERSION", ABColors.theme)
			break
		default:
			break
		}
		
		return tc
	}
	
	enum FormulaType {
		case none, math, physics, chemistry, conversion
	}
}
