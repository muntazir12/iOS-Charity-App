//
//  hajTableViewCell.swift
//  Hjejni
//
//  Created by Muntazir on 30/10/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class hajTableViewCell: UITableViewCell {
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var pidLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    
    class var reuseIdentifier: String {
        get {
            return "hajTableViewCell"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
