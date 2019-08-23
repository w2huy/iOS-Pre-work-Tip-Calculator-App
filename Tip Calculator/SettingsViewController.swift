//
//  SettingsViewController.swift
//  Tip Calculator
//
//  Created by William Huynh on 8/22/19.
//  Copyright © 2019 wi2. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var maxPartyControl: UISegmentedControl!
    @IBOutlet weak var minPartyControl: UISegmentedControl!
    
    //Access UserDefaults
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get an user default values.
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipControlIndex")
        maxPartyControl.selectedSegmentIndex = defaults.integer(forKey: "maxPartyControlIndex")
        minPartyControl.selectedSegmentIndex = defaults.integer(forKey: "minPartyControlIndex")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get an user default values.
        tipControl.selectedSegmentIndex = defaults.integer(forKey: "tipControlIndex")
        maxPartyControl.selectedSegmentIndex = defaults.integer(forKey: "maxPartyControlIndex")
        minPartyControl.selectedSegmentIndex = defaults.integer(forKey: "minPartyControlIndex")
    }
    
    @IBAction func setTipPercentageDefault(_ sender: Any) {
        // Set tip default
        
        defaults.set(tipControl.selectedSegmentIndex, forKey: "tipControlIndex")
        
        // Force UserDefaults to save.
        defaults.synchronize()
    }
    @IBAction func setMaxPartySizeDefault(_ sender: Any) {
        
        if maxPartyControl.selectedSegmentIndex < minPartyControl.selectedSegmentIndex {
            minPartyControl.selectedSegmentIndex = maxPartyControl.selectedSegmentIndex
            defaults.set(minPartyControl.selectedSegmentIndex, forKey: "minPartyControlIndex")
        }
        
        // Set max size default
        defaults.set(maxPartyControl.selectedSegmentIndex, forKey: "maxPartyControlIndex")
        
        // Force UserDefaults to save.
        defaults.synchronize()
    }
    
    @IBAction func setMinPartySizeDefault(_ sender: Any) {
        
        if maxPartyControl.selectedSegmentIndex < minPartyControl.selectedSegmentIndex {
            maxPartyControl.selectedSegmentIndex = minPartyControl.selectedSegmentIndex
            defaults.set(maxPartyControl.selectedSegmentIndex, forKey: "maxPartyControlIndex")
        }
        
        // Set min size default
        defaults.set(minPartyControl.selectedSegmentIndex, forKey: "minPartyControlIndex")
        
        // Force UserDefaults to save.
        defaults.synchronize()
    }
    
    
    
}
