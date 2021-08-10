//
//  ImageZoomViewController.swift
//  PhotosExample
//
//  Created by 김지수 on 2021/08/10.
//

import UIKit
import Photos

class ImageZoomViewController: UIViewController, UIScrollViewDelegate {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var imageView: UIImageView!
  
  var asset : PHAsset!
  let imageManager : PHCachingImageManager = PHCachingImageManager()
  
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return self.imageView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "사진"
    self.scrollView.delegate = self
    imageManager.requestImage(for: asset,
                              targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight),
                              contentMode: .aspectFill, options: nil,
                              resultHandler: { image, _ in self.imageView.image = image
                                print("why")
                              })
  }
}
