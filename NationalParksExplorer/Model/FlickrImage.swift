//
//  FlickrImage.swift
//  NationalParksExplorer
//
//  Created by Matthew Curran on 4/9/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import UIKit

class FlickrImage {
    
    var photoData: FlickrPhotoData?
    var thumbnail: UIImage?
    var full: UIImage?
    
    init(photoData: FlickrPhotoData) {
        self.photoData = photoData
    }
    
    var thumbnailURL: String? {
        guard let photo = photoData else { return nil }
        return "https://farm\(photo.farm).staticflickr.com/(photo.server)/\(photo.id)_\(photo.secret)_q.jpg"
    }
    
    var fullURL: String? {
        guard let photo = photoData else { return nil }
        // The following edited thanks to Cara's post in the Slack:
        return "https://farm\(photo.farm).staticflickr.com/(photo.server)/\(photo.id)_\(photo.secret)_b.jpg"
    }
}
