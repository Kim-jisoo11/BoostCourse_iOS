//
//  ThirdViewController.swift
//  SignUp
//
//  Created by 김지수 on 2021/08/07.
//

import UIKit

class ThirdViewController: UIViewController {
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var numberTextField: UITextField!
  @IBOutlet weak var birthdayLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var datePicker: UIDatePicker!
  @IBOutlet weak var signupButton: UIButton!
  var saveUserID : String = "" /// UserID 저장용
  var dateisfull : Bool = false
  var numberisfull : Bool = false
  let dateFormatter: DateFormatter = {
    let formatter: DateFormatter = DateFormatter()
    formatter.dateStyle = .medium
    /// 원하는 대로 custom 하고 싶으면
    //formatter.dateFormat = "yyyy/MM/dd hh:mm:ss"
    return formatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textFieldRight()
    self.datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(_:)), for: UIControl.Event.valueChanged)
    
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  @IBAction func datePickerValueChanged(_ sender: Any) {
    let date: Date = self.datePicker.date
    let dateString: String = self.dateFormatter.string(from: date)
    self.dateLabel.text = dateString
    dateisfull = true
    if dateisfull == true && numberisfull == true {
      signupButton.setTitleColor(.blue, for: .normal)
    } else {
      signupButton.setTitleColor(.gray, for: .normal)
    }
  }
  @IBAction func cancelButtonClicked(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
    }
  
  
  @IBAction func beforeButtonClicked(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
  }
  
  @IBAction func signupButtonClicked(_ sender: Any) {
    if dateisfull == true && numberisfull == true {
      ///확인 버튼을 누를 때만 saveuserID에 저장되어 있던 ID값이 UserInformation에 전달되도록!
      UserInformation.shared.userID = self.saveUserID
      ///navigation 과 modal 한번에 닫고 첫화면으로 돌아가기
      self.navigationController?.dismiss(animated: true, completion: {
           self.navigationController?.popViewController(animated: true)
      })
    }
  }
}

extension ThirdViewController {
  func textFieldRight(){
    numberTextField.delegate = self
  }
}

extension ThirdViewController : UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    if numberTextField.text != "" {
      numberisfull = true
    } else {
      numberisfull = false
    }
  }
}
