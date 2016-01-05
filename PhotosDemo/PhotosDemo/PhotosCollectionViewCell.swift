import UIKit
import Photos

class PhotosCollectionViewCell: UICollectionViewCell {
    var imageManager: PHImageManager!
    
    let photoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(photoImageView)
    
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor).active = true
        photoImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor).active = true
        photoImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor).active = true
        photoImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor).active = true
        
        photoImageView.widthAnchor.constraintEqualToConstant(imageWidth).active = true
        photoImageView.heightAnchor.constraintEqualToConstant(imageWidth).active = true
        
        photoImageView.contentMode = .ScaleAspectFill
        contentView.backgroundColor = UIColor.redColor()
        contentView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var imageAsset: PHAsset? {
      didSet {
        self.imageManager.requestImageForAsset(imageAsset!, targetSize: CGSize(width: imageWidth, height: imageWidth), contentMode: .AspectFill, options: nil) {
                image, _ in

                guard let image = image else {
                    print("image was nil")
                    return
                }
                self.photoImageView.image = image
                self.contentView.addSubview(self.photoImageView)
            }
        }
    }
}
