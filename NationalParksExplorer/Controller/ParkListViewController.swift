//
//  ViewController.swift
//  NationalParksExplorer
//
//  Created by Matthew Curran on 4/9/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import UIKit

class ParkListViewController: UIViewController {

    @IBOutlet var statePickerView: UIPickerView!
    @IBOutlet var parkPickerView: UIPickerView!
    
    var statePicker: StatePicker?
    var parkPicker: ParkPicker?
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        statePicker = StatePicker(states: States.stateNames)
        statePickerView.dataSource = statePicker
        statePickerView.delegate = statePicker
        
        parkPicker = ParkPicker()
        parkPickerView.dataSource = parkPicker
        parkPickerView.delegate = parkPicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showParksButtonTapped(_ sender: Any) {
        let row = statePickerView.selectedRow(inComponent: 0)
        let stateName = statePicker!.stateFor(row: row)
        let stateAbbr = States.stateAbbreviation(for: stateName)
        getParks(for: stateAbbr!)
    }
    
    func getParks(for state: String) {
        
        let service = NationalParkService()
        
        loadingIndicator.startAnimating()
        
        service.fetchParks(for: state) { (parks: [NationalPark]?, error: Error?) -> Void in
            
            DispatchQueue.main.async {
                
                self.loadingIndicator.stopAnimating()
                
                if let error = error {
                    print(error)
                    self.present(ErrorAlertController.alert(message: "Unable to fetch parks."), animated: true)
                }
                
                if let parks = parks {
                    self.parkPicker!.parks = parks
                    self.parkPickerView.reloadAllComponents()
                    self.parkPickerView.selectRow(0, inComponent: 0, animated: true)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "explorePark" {
            let selectedRow = parkPickerView.selectedRow(inComponent: 0)
            let park = parkPicker?.parkFor(row: selectedRow)
            
            let imageViewController = segue.destination as! ImageCollectionViewController
            imageViewController.park = park
        }
    }
    
}

