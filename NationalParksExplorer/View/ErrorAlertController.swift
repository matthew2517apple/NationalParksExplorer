//
//  ErrorAlertController.swift
//  NationalParksExplorer
//
//  Created by Matthew Curran on 4/9/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import UIKit

class ErrorAlertController {
    
    static func alert(title: String = "Error", message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        return alert
    }
}
