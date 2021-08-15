//
//  ViewController.swift
//  Assign4_Album
//
//  Created by 김지수 on 2021/08/11.
//

import UIKit
import Photos

class ViewController: UIViewController,PHPhotoLibraryChangeObserver {
  
  @IBOutlet weak var collectionView: UICollectionView!
  var fetchResult : PHFetchResult<PHAsset>!
  var albumList : PHFetchResult<PHAssetCollection>!
  
  let imageManager : PHCachingImageManager = PHCachingImageManager()
  let cellIdentifier : String = "AlbumCollectionViewCell"
  
  func requestCollection () {
    let cameraRoll : PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
    guard let cameraRollCollection = cameraRoll.firstObject else {
      return
    }
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    
  }
  func GetAlbums() {
    let options : PHFetchOptions = PHFetchOptions()
    let getAlbums : PHFetchResult = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: options)
    guard let collectionImage = getAlbums.firstObject else {
      
      return
    }
    print(getAlbums)
    for i in 0 ..< getAlbums.count {
      let collection = getAlbums[i]
      let title : String = collection.localizedTitle ?? ""
      if(collection.estimatedAssetCount != nil) {
        let count : Int = collection.estimatedAssetCount
        print(count)
        print(title)
      } else {
      }
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    
    
    let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
    
    switch photoAuthorizationStatus {
    case .authorized :
      print("접근 허가됨")
      self.GetAlbums()
      self.collectionView.reloadData()
    case .denied :
      print("접근 불허")
    case .notDetermined :
      print("아직 응답하지 않음")
      PHPhotoLibrary.requestAuthorization({ (status) in
        switch status {
        case .authorized :
          print("사용자가 허용함")
          self.GetAlbums()
          OperationQueue.main.addOperation {
            self.collectionView.reloadData()
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
    guard let changes = changeInstance.changeDetails(for: albumList) else {return}
    albumList = changes.fetchResultAfterChanges
    OperationQueue.main.addOperation {
      self.collectionView.reloadSections(IndexSet(0...0))
    }
  }
}

extension ViewController : UICollectionViewDelegate {
  
}
extension ViewController : UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.fetchResult?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell : AlbumCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! AlbumCollectionViewCell
    
    //    let asset : PHAsset = fetchResult.object(at: indexPath.row)
    //    let album : PHAssetCollection = albumList.object(at: indexPath.row)
    guard let asset =
            
            imageManager.requestImage(for: asset,
                                      targetSize: CGSize(width: 100, height: 100),
                                      contentMode: .aspectFill, options: nil, resultHandler: {image, _ in cell.albumImageView?.image = image})
    return cell
  }
  
  
}

