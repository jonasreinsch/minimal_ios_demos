//
// Copyright 2014 Scott Logic
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import UIKit
import Photos

class PhotosCollectionViewCell: UICollectionViewCell {
    var imageManager: PHImageManager!
    
    let photoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
//        photoImageView.frame = CGRectMake(0, 0, 320, 320)
    
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.leadingAnchor.constraintEqualToAnchor(contentView.leadingAnchor).active = true
        photoImageView.trailingAnchor.constraintEqualToAnchor(contentView.trailingAnchor).active = true
        photoImageView.topAnchor.constraintEqualToAnchor(contentView.topAnchor).active = true
        photoImageView.bottomAnchor.constraintEqualToAnchor(contentView.bottomAnchor).active = true
        
        photoImageView.contentMode = .ScaleAspectFill
        contentView.backgroundColor = UIColor.redColor()
        contentView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFittingAttributes(layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attr = layoutAttributes.copy() as! UICollectionViewLayoutAttributes

        attr.frame.size.height = 320
        return attr
    }

  var imageAsset: PHAsset? {
    didSet {
      self.imageManager.requestImageForAsset(imageAsset!, targetSize: CGSize(width: 320, height: 320), contentMode: .AspectFill, options: nil) {
        image, _ in

        guard let image = image else {
            fatalError("image was nil")
        }
        self.photoImageView.image = image
        self.contentView.addSubview(self.photoImageView)
      }
    }
  }

}
