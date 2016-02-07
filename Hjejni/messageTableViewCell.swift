//
//  messageTableViewCell.swift
//  Hjejni
//
//  Created by Muntazir on 02/11/15.
//  Copyright © 2015 Hjejni. All rights reserved.
//

import UIKit

class messageTableViewCell: UITableViewCell {
    @IBOutlet weak var semailLabel: UILabel!
    @IBOutlet weak var rtableLabel: UILabel!
    @IBOutlet weak var rpidLabel: UILabel!
    @IBOutlet weak var remailLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rnameLabel: UILabel!

    class var reuseIdentifier: String {
        get {
            return "messageTableViewCell"
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
