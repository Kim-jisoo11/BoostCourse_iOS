//
//  SecondViewController.swift
//  Signup
//
//  Created by 김지수 on 2021/08/06.
//

import UIKit

class InfoViewController: UIViewController {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var ageLabel: UILabel!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.nameLabel.text = UserInformation.shared.name
    self.ageLabel.text = UserInformation.shared.age
  }
  
  @IBAction func popButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true
    )
  }
  
}
