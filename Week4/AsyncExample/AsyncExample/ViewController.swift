//
//  ViewController.swift
//  AsyncExample
//
//  Created by 김지수 on 2021/08/10.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!
  @IBAction func downloadButtonClicked(_ sender: Any) {
    //이미지 다운로드 -> 이미지 뷰에 셋팅

    let imageURL : URL = URL(string : "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/LARGE_elevation.jpg/1600px-LARGE_elevation.jpg")!
    
    OperationQueue().addOperation {
      let imageData : Data = try! Data.init(contentsOf: imageURL)
      let image : UIImage = UIImage(data: imageData)!
      
      OperationQueue.main.addOperation {
        self.imageView.image = image
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }


}

