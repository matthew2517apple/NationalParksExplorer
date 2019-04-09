//
//  NationalPark.swift
//  NationalParksExplorer
//
//  Created by Matthew Curran on 4/9/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import Foundation

struct NationalParkResult: Decodable {
    let total: String
    let data: [NationalPark]
}

struct NationalPark: Decodable {
    let states: String
    let description: String
    let fullName: String
}
