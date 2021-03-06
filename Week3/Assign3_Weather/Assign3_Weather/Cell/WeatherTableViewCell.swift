//
//  WeatherTableViewCell.swift
//  Assign3_Weather
//
//  Created by 김지수 on 2021/08/08.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
  static let identifier : String = "WeatherTableViewCell"
  
  @IBOutlet weak var weatherImageView: UIImageView!
  @IBOutlet weak var citynameLabel: UILabel!
  @IBOutlet weak var degreeLabel: UILabel!
  @IBOutlet weak var rainfallLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
