//
//  CustomTableViewCell.swift
//  SimpleTable
//
//  Created by 김지수 on 2021/08/08.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
  @IBOutlet weak var leftLabel: UILabel!
  @IBOutlet weak var rightLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
