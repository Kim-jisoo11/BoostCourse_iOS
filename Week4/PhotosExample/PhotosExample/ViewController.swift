//
//  ViewController.swift
//  PhotosExample
//
//  Created by 김지수 on 2021/08/10.
//

import UIKit
import Photos

class ViewController: UIViewController, PHPhotoLibraryChangeObserver {
  @IBOutlet weak var tableView: UITableView!
  var fetchResult : PHFetchResult<PHAsset>!
  let imageManager : PHCachingImageManager = PHCachingImageManager()
  let cellIdentifier : String = "cell"
  @IBAction func refreshButtonClicked(_ sender: Any) {
    self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
  }
  
  func requestCollection () {
    
    let cameraRoll : PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
    guard let cameraRollCollection = cameraRoll.firstObject else {
      return
    }
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
    
    switch photoAuthorizationStatus {
    case .authorized :
      print("접근 허가됨")
      self.requestCollection()
      self.tableView.reloadData()
    case .denied :
      print("접근 불허")
    case .notDetermined :
      print("아직 응답하지 않음")
      PHPhotoLibrary.requestAuthorization({ (status) in
        switch status {
        case .authorized :
          print("사용자가 허용함")
          self.requestCollection()
          OperationQueue.main.addOperation {
            self.tableView.reloadData()
          }
        case .denied :
          print("사용자가 불허함")
        default : break
        }
      })
    case .restricted :
      print("접근 제한")
    case .limited:
      print("moya")
    @unknown default:
      print("ang")
    }
    PHPhotoLibrary.shared().register(self)
  }
  func photoLibraryDidChange(_ changeInstance: PHChange) {
    guard let changes = changeInstance.changeDetails(for: fetchResult) else {return}
    fetchResult = changes.fetchResultAfterChanges
    OperationQueue.main.addOperation {
      self.tableView.reloadSections(IndexSet(0...0), with: .automatic)
    }
  }
}
extension ViewController : UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "ImageZoomViewController") as? ImageZoomViewController else { return }
    nextVC.asset = self.fetchResult[indexPath.row]
    self.navigationController?.pushViewController(nextVC, animated: true)
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let asset : PHAsset = self.fetchResult[indexPath.row]
      PHPhotoLibrary.shared().performChanges({PHAssetChangeRequest.deleteAssets([asset] as NSArray)}, completionHandler: nil)
    }
  }
}

extension ViewController : UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.fetchResult?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
    print(cell)
    let asset : PHAsset = fetchResult.object(at: indexPath.row)
    print(asset)
    
    imageManager.requestImage(for: asset,
                              targetSize: CGSize(width: 30, height: 30),
                              contentMode: .aspectFill, options: nil, resultHandler: {image, _ in cell.imageView?.image = image})
    return cell
  }
}
