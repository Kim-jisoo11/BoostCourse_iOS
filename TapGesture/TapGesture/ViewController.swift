//
//  ViewController.swift
//  TapGesture
//
//  Created by 김지수 on 2021/08/06.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
  
///1. IBAction을 통해 구현하는 경우
//  @IBAction func tapView(_ sender: UITapGestureRecognizer) {
//    self.view.endEditing(true)
//  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    ///3. Tap Gesture를 Delegate를 이용해 구현한다면
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    tapGesture.delegate = self
    self.view.addGestureRecognizer(tapGesture)
  }
    
    ///2. Tap Gesture를 단순히 코드로 구현한다면
//    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
//                                                                    action: #selector(self.tapView(_:)))
//
//    self.view.addGestureRecognizer(tapGesture)
    
  
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    self.view.endEditing(true)
    return false
  }


}

