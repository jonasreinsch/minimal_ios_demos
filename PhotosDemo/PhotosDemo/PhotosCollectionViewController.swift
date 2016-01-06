// as simple as possible, possible improvements
// - implement PHPhotoLibraryChangeObserver
// - use PHCachingImageManager and implement image caching

import UIKit
import Photos

let reuseIdentifier = "__IMAGE_CELL__"

class PhotosCollectionViewController: UICollectionViewController
{
    var images: PHFetchResult!

    let imageManager = PHImageManager.defaultManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        guard let collectionView = collectionView else {
            fatalError("collectionView was nil")
        }
        
        collectionView.registerClass(PhotosCollectionViewCell.self,
                                     forCellWithReuseIdentifier: reuseIdentifier)
    
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]

        images = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
  
  // MARK: UICollectionViewDataSource
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotosCollectionViewCell
    
    cell.imageAsset = images[indexPath.item] as? PHAsset
    
    return cell
  }
}
