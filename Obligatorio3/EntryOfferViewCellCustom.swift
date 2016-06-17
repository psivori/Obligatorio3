//
//  EntryOfferViewCellCustom.swift
//  Obligatorio3
//
//  Created by Administrador on 16/6/16.
//  Copyright © 2016 MICHO. All rights reserved.
//

import UIKit

class EntryOfferViewCellCustom: UITableViewCell {
    
  
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var titleLable: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}