//
//  ViewController.swift
//  Signup
//
//  Created by 김지수 on 2021/08/06.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var ageTextField: UITextField!
  
  @IBAction func setButtonClicked(_ sender: Any) {
    UserInformation.shared.name = nameTextField.text
    UserInformation.shared.age = ageTextField.text
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
  
  @IBAction func pushButtonClicked(_ sender: Any) {
    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "InfoViewController") as? InfoViewController else { return }
    self.navigationController?.pushViewController(nextVC, animated: true)
  }
  
}

