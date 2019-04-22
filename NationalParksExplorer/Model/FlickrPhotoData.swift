//
//  FlickrPhotoData.swift
//  NationalParksExplorer
//
//  Created by Matthew Curran on 4/9/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import Foundation
import UIKit

struct FlickrPhotoData: Decodable {
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let isPublic: Int
}

struct FlickrPhotoResponse: Decodable {
    let photo: [FlickrPhotoData]
}

struct FlickrResponse: Decodable {
    let photos: FlickrPhotoResponse
}
