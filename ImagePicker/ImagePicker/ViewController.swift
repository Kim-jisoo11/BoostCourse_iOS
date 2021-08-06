//
//  ViewController.swift
//  ImagePicker
//
//  Created by 김지수 on 2021/08/06.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  lazy var imagePicker : UIImagePickerController = {
    let picker : UIImagePickerController = UIImagePickerController()
    picker.sourceType = .photoLibrary
    picker.delegate = self
    return picker
  }()
  
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBAction func buttonClicked(_ sender: Any) {
    self.present(self.imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    self.dismiss(animated: true, completion: nil)
  }
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let originalImage : UIImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
      self.imageView.image = originalImage
    }
    self.dismiss(animated: true, completion: nil)
  }
  
  // MARK : LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }
  
}

