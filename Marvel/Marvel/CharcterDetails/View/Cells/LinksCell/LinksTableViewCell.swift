//
//  LinksTableViewCell.swift
//  Marvel
//
//  Created by Ann Mohamed on 04/02/2024.
//

import UIKit

class LinksTableViewCell: UITableViewCell {

    @IBOutlet weak var linkNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
