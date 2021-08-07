//
//  ViewController.swift
//  SignUp
//
//  Created by 김지수 on 2021/08/07.
//

import UIKit

class ViewController: UIViewController {
  
  //MARK : Properties
  
  @IBOutlet weak var rupiImageView: UIImageView!
  @IBOutlet weak var idTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBAction func signupButtonClicked(_ sender: Any) {
    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController else {return}
    
    nextVC.modalPresentationStyle = .fullScreen
    self.navigationController?.present(nextVC, animated: true, completion: nil)
  }
  
  //MARK : LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.idTextField.text = UserInformation.shared.userID
  }


}

