//
//  ImageCollectionViewController.swift
//  NationalParksExplorer
//
//  Created by Matthew Curran on 4/9/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import UIKit

class ImageCollectionViewController: UICollectionViewController {
    
    var park: NationalPark?
    let reuseIdentifier = "UICollectionViewCell"
    var photoSet: FlickrPhotoSet?
    let flickrService = FlickrService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flickrService.searchPhotos(query: park!.fullName) { (photos: [FlickrPhotoData]?, error: Error?) -> Void in
            
            DispatchQueue.main.async {
                if error != nil {
                    self.present(ErrorAlertController.alert(message: "Unable to fetch photos."), animated: true)
                }
                
                if let photos = photos {
                    if photos.count == 0 {
                        self.present(ErrorAlertController.alert(message: "No photos found, try another park?"), animated: true)
                    } else {
                        print(photos)
                        self.photoSet = FlickrPhotoSet(photos: photos)
                        self.collectionView?.reloadData()
                    }
                }
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoSet?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        guard let photoSet = photoSet else {
            cell.image.image = UIImage(named: "placeholder")
            return cell
        }
        
        if let thumbnail = photoSet.images[indexPath.row].thumbnail {
            cell.image.image = thumbnail
        }
        
        else {
            cell.image.image = UIImage(named: "placeholder")
            requestThumbnail(for: indexPath.row)
        }
        
        return cell
    }
    
    func requestThumbnail(for index: Int) {
        let imageData = self.photoSet?.images[index]
        
        flickrService.downloadImage(url: imageData!.thumbnailURL!) { (thumbnail: UIImage?, error: Error?) in
            self.photoSet?.images[index].thumbnail = thumbnail
            DispatchQueue.main.async {
                self.collectionView?.reloadItems(at: [IndexPath(row: index, section: 0)])
            }
        }
    }
    
}
