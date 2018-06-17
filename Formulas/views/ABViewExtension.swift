//
//  ABViewExtension.swift
//  Formulas
//
//  Created by Albin Bååw on 2018-06-06.
//  Copyright © 2018 Albin Bååw. All rights reserved.
//

import UIKit

extension UIView {
	
	internal func setCornerRadius(_ radius:CGFloat){
		self.layer.cornerRadius = radius
		self.layer.masksToBounds = true
	}
	
	var firstResponder: UIView? {
		guard !isFirstResponder else { return self }
		
		for subview in subviews {
			if let firstResponder = subview.firstResponder {
				return firstResponder
			}
		}
		
		return nil
	}

}
