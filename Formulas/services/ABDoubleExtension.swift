//
//  ABDoubleExtension.swift
//  Formulas
//
//  Created by Albin Bååw on 2018-06-07.
//  Copyright © 2018 Albin Bååw. All rights reserved.
//

import UIKit

extension Double{
	
	func roundTo(amountOfDigits digits: Int) -> Double{
		let divisor = pow(10.0, Double(digits))
		return (self * divisor).rounded() / divisor
	}

}
