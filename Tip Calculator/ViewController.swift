//
//  ViewController.swift
//  Tip Calculator
//
//  Created by William Huynh on 8/21/19.
//  Copyright © 2019 wi2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipTextLabel: UILabel!
    @IBOutlet weak var amountPerLabel: UILabel!
    @IBOutlet weak var partySizeLabel: UILabel!
    
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var partySizeView: UIView!
    @IBOutlet weak var totalView: UIView!
    @IBOutlet weak var amountPerView: UIView!
    @IBOutlet weak var billView: UIView!
    
    //Access UserDefaults
    let defaults = UserDefaults.standard
    var maxPartySize = 0
    var minPartySize = 0
    var viewPresentationState = Presentation.show
    
    enum Presentation {
        case show
        case hide
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get an user default values.
        setTipMaxMin()
        
//        dismissViewsNoAnimation()
        
        //Present Keyboard
        billTextField.becomeFirstResponder()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get an user default values.
        setTipMaxMin()
//
//        dismissViewsNoAnimation()
        
    }
    
    func animateViews() {
        
        viewPresentationState = (billTextField.text == "") ? .hide : .show
        
        switch viewPresentationState {
        case .hide:
            dismissViews()
        case .show:
            callViews()
        }

    }
    
    
    @IBAction func calculateTip(_ sender: Any) {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        // Get the bill
        let bill = Double(billTextField.text!) ?? 0
        
        // Get the party size
        let size = Double(partySizeLabel.text!) ?? 2
        
        // Get the tip percent
        let percentage = tipTextLabel.text?.prefix(2)
        let percentTip = Double(percentage!)! / 100
        
        // Calculate the tip, total,amountPer
        let tip = bill * percentTip
        let total = bill + tip
        let amountPer = total / size
        
        tipLabel.text = formatNumberLabels(num: tip)
        totalLabel.text = formatNumberLabels(num: total)
        amountPerLabel.text = formatNumberLabels(num: amountPer)
        
        animateViews()
        
    }
    
    
    
    @IBAction func partySizeTapped(_ sender: Any) {
        
        var nextPartySize = ((Int(partySizeLabel.text!) ?? 9) + 1) % maxPartySize
        
        if nextPartySize < minPartySize {
            nextPartySize = minPartySize
        }
        
        partySizeLabel.text = "\(nextPartySize)"
        
        colorChangeAnimation()
        
        calculateTip(0)
        
    }
    
    
    
    @IBAction func tipTapped(_ sender: Any) {
        
        let lastTipPercent = tipTextLabel.text?.prefix(2)
        
        let tipOptions = [15, 18, 20]
        
        if String(tipOptions[0]) == String(lastTipPercent!) {
            tipTextLabel.text = "\(String(tipOptions[1]))% Tip"
        } else if String(tipOptions[1]) == String(lastTipPercent!) {
            tipTextLabel.text = "\(String(tipOptions[2]))% Tip"
        } else if String(tipOptions[2]) == String(lastTipPercent!) {
            tipTextLabel.text = "\(String(tipOptions[0]))% Tip"
        }
        
        colorChangeAnimation()
        
        calculateTip(0)
    }
    
    func setTipMaxMin() {
        
        let tipOptions = [15, 18, 20]
        
        tipTextLabel.text = "\(String(tipOptions[defaults.integer(forKey: "tipControlIndex")]))% Tip"
        
        let maxSizes = [5, 9, 17, 33, 65]
        let minSizes = [2, 4, 8, 16, 32]
        
        let maxSizeIndex = defaults.integer(forKey: "maxPartyControlIndex")
        let minSizeIndex = defaults.integer(forKey: "minPartyControlIndex")
        
        maxPartySize = maxSizes[maxSizeIndex]
        minPartySize = minSizes[minSizeIndex]
        
        partySizeLabel.text = "\(minPartySize)"
        
        calculateTip(0)
    }
    
    func formatNumberLabels(num:Double) -> String {
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        let priceString = currencyFormatter.string(from: NSNumber(value: num))!
        
        return priceString
    }
    
    func colorChangeAnimation() {
        let greenValue = CGFloat(Float.random(in: 0.5 ..< 1))
        
        UIView.animate(withDuration: 0.1) {
            self.tipView.backgroundColor = UIColor(red: 0, green: greenValue, blue: 255, alpha: 0.8)
            self.totalView.backgroundColor = UIColor(red: 0, green: (greenValue/1.45), blue: 255, alpha: 0.8)
            self.amountPerView.backgroundColor = UIColor(red: 0, green: (greenValue/1.30), blue: 255, alpha: 0.8)
            self.partySizeView.backgroundColor = UIColor(red: 0, green: (greenValue/1.15), blue: 255, alpha: 0.8)
        }
        
    }
    
    func callViews() {
        
        //Present Views
        UIView.animate(withDuration: 0.3, animations: {
            self.billView.center.y = self.billView.frame.height/2
        }) { (finished: Bool) -> Void in

            UIView.animate(withDuration: 0.3, animations: {
                self.tipView.alpha = 1.0
                self.totalView.alpha = 1.0
                self.amountPerView.alpha = 1.0
                self.partySizeView.alpha = 1.0
            }, completion: nil)
        }
    }
    
    func dismissViews() {
        
        //Dismiss Views
        UIView.animate(withDuration: 0.3) {
            self.billView.center.y = self.view.frame.height/2 - 100
            
            self.tipView.alpha = 0
            self.totalView.alpha = 0
            self.amountPerView.alpha = 0
            self.partySizeView.alpha = 0
        }
    }
    
}
