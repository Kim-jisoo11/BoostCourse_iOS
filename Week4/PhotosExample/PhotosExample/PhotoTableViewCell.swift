//
//  PhotoTableViewCell.swift
//  PhotosExample
//
//  Created by 김지수 on 2021/08/10.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
  @IBOutlet weak var photoImageView: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
