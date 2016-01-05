import UIKit
import Photos

let reuseIdentifier = "__IMAGE_CELL__"

class PhotosCollectionViewController: UICollectionViewController,
                                      PHPhotoLibraryChangeObserver
{
    var images: PHFetchResult!

    let imageManager = PHImageManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let collectionView = collectionView else {
            fatalError("collectionView was nil")
        }
        
        collectionView.registerClass(PhotosCollectionViewCell.self,
                                     forCellWithReuseIdentifier: reuseIdentifier)
    
        images = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
        
        print(images.count)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
  
  // MARK: UICollectionViewDataSource
  
  override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotosCollectionViewCell
    
    cell.imageManager = imageManager
    cell.imageAsset = images[images.count - (indexPath.item + 1)] as? PHAsset
    
    return cell
  }
  
  // MARK: - PHPhotoLibraryChangeObserver
  func photoLibraryDidChange(changeInstance: PHChange) {
    let changeDetails = changeInstance.changeDetailsForFetchResult(images)
    
    self.images = changeDetails!.fetchResultAfterChanges
    dispatch_async(dispatch_get_main_queue()) {
      // Loop through the visible cell indices
      let indexPaths = self.collectionView?.indexPathsForVisibleItems()
      for indexPath in indexPaths as [NSIndexPath]! {
        if changeDetails!.changedIndexes!.containsIndex(indexPath.item) {
          let cell = self.collectionView?.cellForItemAtIndexPath(indexPath) as! PhotosCollectionViewCell
          cell.imageAsset = changeDetails!.fetchResultAfterChanges[indexPath.item] as? PHAsset
        }
      }
    }
  }
}
