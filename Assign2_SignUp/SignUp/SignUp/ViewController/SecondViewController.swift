//
//  SecondViewController.swift
//  SignUp
//
//  Created by 김지수 on 2021/08/07.
//

import UIKit

class SecondViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  //MARK : Properties
  
  lazy var imagePicker : UIImagePickerController = {
    let picker : UIImagePickerController = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.delegate = self
    return picker
  }()
  
  
  @IBOutlet weak var userImageView: UIImageView!
  @IBOutlet weak var useridTextField: UITextField!
  @IBOutlet weak var userpasswordTextField: UITextField!
  @IBOutlet weak var usercheckpasswordTextField: UITextField!
  @IBOutlet weak var explainTextView: UITextView!
  @IBOutlet weak var cancelButton: UIButton!
  var idfull : Bool = false
  var pwfull : Bool = false
  var pwcfull : Bool = false
  var Imgfull : Bool = false
  var explainfull : Bool = false
  var passwordstatus : Bool = false
  var cangoNext : Bool = false
 
  @IBAction func ImageButtonClicked(_ sender: Any) {
    self.present(self.imagePicker, animated: true, completion: nil)
  }
  /// ImagePicker
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let originalImage : UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.userImageView.image = originalImage
      Imgfull = true
    }
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cancelButtonClicked(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func nextButtonClicked(_ sender: Any) {
    
    /// 만약 모든 조건을 만족시킨다면 다음 화면으로 넘어가게
    if cangoNext == true {
      
      guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ThirdViewController") as? ThirdViewController else {return}
      self.navigationController?.pushViewController(nextVC, animated: true)
//      nextVC.modalTransitionStyle = .crossDissolve
//      nextVC.modalPresentationStyle = .fullScreen
//      self.present(nextVC, animated: true, completion: nil)
      ///userInformation에 유저 아이디 저장
      UserInformation.shared.userID = useridTextField.text
      
    }
  }
  
  
  //MARK : LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    textFieldRight()
    textViewRight()
  }
  override func viewWillAppear(_ animated: Bool) {
    self.reloadInputViews()
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
}


extension SecondViewController {
  func textFieldRight(){
    useridTextField.delegate = self
    userpasswordTextField.delegate = self
    usercheckpasswordTextField.delegate = self
  }
  func textViewRight(){
    explainTextView.delegate = self
  }
}

extension SecondViewController : UITextFieldDelegate {
  func textFieldDidEndEditing(_ textField: UITextField) {
    let userID = useridTextField.text
    let userPW = userpasswordTextField.text
    let userCheckPW = usercheckpasswordTextField.text
    if userID != "" {
      idfull = true
    } else {
      idfull = false
    }
    if userPW != "" {
      pwfull = true
    } else {
      pwfull = false
    }
    if userCheckPW != "" {
      pwcfull = true
    } else {
      pwcfull = false
    }
    if pwfull == true {
      if pwcfull == true {
        if userPW == userCheckPW {
          passwordstatus = true
        } else {
          passwordstatus = false
        }
      }
    }
    
    if idfull == true && passwordstatus == true && explainfull == true && Imgfull == true {
      print("조건 만족")
      cancelButton.setTitleColor(.blue, for: .normal)
      cangoNext = true
    } else {
      print("조건 불만족")
      cancelButton.setTitleColor(.gray, for: .normal)
      cangoNext = false
    }
  }
}

extension SecondViewController : UITextViewDelegate {
  func textViewDidEndEditing(_ textView: UITextView) {
    /// explainTextView가 비어있는지 검사
    let explainT = explainTextView.text
    if explainT != "" {
      explainfull = true
    } else {
      explainfull = false
    }
  }
}
