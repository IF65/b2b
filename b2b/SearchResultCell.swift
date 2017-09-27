//
//  SearchResultCell.swift
//  b2b
//
//  Created by if65 on 27/09/2017.
//  Copyright © 2017 if65. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var codiceGcc: UILabel!
    @IBOutlet weak var codiceSM: UILabel!
    @IBOutlet weak var descrizione: UILabel!
    @IBOutlet weak var marchio: UILabel!
    @IBOutlet weak var modello: UILabel!
    
    

}
