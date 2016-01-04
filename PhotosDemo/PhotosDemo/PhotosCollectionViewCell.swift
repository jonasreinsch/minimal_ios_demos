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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(photoImageView)
        photoImageView.frame = CGRectMake(0, 0, 320, 320)
        photoImageView.contentMode = .ScaleAspectFill
        contentView.backgroundColor = UIColor.redColor()
        contentView.clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
  var imageAsset: PHAsset? {
    didSet {
      self.imageManager?.requestImageForAsset(imageAsset!, targetSize: CGSize(width: 320, height: 320), contentMode: .AspectFill, options: nil) { image, info in
        if let image = image {
            print("eins")

            self.photoImageView.image = image
            
            self.contentView.addSubview(self.photoImageView)
            print("zwei")
        } else {
            print("image was nil")
        }
      }
        print(contentView.frame)
//      starButton.alpha = imageAsset!.favorite ? 1.0 : 0.4
    }
  }
  
  var imageManager: PHImageManager?
    
  let photoImageView = UIImageView()
}
