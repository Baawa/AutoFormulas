//
//  ABSearchTVC.swift
//  Formulas
//
//  Created by Albin Bååw on 2018-06-14.
//  Copyright © 2018 Albin Bååw. All rights reserved.
//

import UIKit

class ABSearchTVC: UITableViewCell {
	
	var tagView:ABTagView?{
		didSet{
			self.addSubview(tagView!)
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
		self.tagView?.removeFromSuperview()
	}

}
