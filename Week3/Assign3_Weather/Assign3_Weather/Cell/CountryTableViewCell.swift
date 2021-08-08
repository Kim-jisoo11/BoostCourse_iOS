//
//  CountryTableViewCell.swift
//  Assign3_Weather
//
//  Created by 김지수 on 2021/08/08.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
  static let identifier : String = "CountryTableViewCell"
  
  @IBOutlet weak var countryImageView: UIImageView!
  @IBOutlet weak var countryLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
