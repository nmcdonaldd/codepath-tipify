//
//  tipViewController.swift
//  tipify
//
//  Created by Nick McDonald on 12/16/16.
//  Copyright © 2016 Nick McDonald. All rights reserved.
//

import UIKit

class tipViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var totalBillTextField: UITextField!
    @IBOutlet weak var scAndBillTFView: UIView!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tipAndTotalView: UIView!
    private var previousText:Bool = false
    private var previousShownKeyboard = false
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    private var manager: tipManager!
    private var locationManager: tipLocationManager!
    
    private var dollarSignForLocation: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShown(notification:)), name: .UIKeyboardWillShow, object: nil)

        // Do any additional setup after loading the view.
        self.tipAndTotalView.alpha = CGFloat(tipHideAlpha)
        self.tipSegmentedControl.alpha = CGFloat(tipHideAlpha)
        
        self.manager = tipManager.sharedInstance
        self.locationManager = self.manager.locationManager
		
		self.totalBillTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.setPlaceHolderBasedOnLocation), name: NSNotification.Name(rawValue: tipLocationUpdatedKey), object: nil)
    }
    
    func setPlaceHolderBasedOnLocation() {
        let country = self.locationManager.getLatestCountry()
        self.dollarSignForLocation = dollarSignsForCountry[country] ?? dollarSignsForCountry[tipDefaultUserLocation]
        NSLog("Dollar localization of %@ is %@", country, self.dollarSignForLocation)
        
        self.totalBillTextField.placeholder = self.dollarSignForLocation
    }
    
    func keyboardShown(notification: Notification) {
		
		if previousText {
			return
		}
		
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            self.tipAndTotalView.frame.origin.y = keyboardSize.minY - keyboardSize.height
        }
		
        previousShownKeyboard = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // Make the textfield the first responder.
        totalBillTextField.becomeFirstResponder()
    }
    
    private func animateViewsIfPreviousText() {
        
        let isText = self.totalBillTextField.text != ""
        if previousText && isText {
            return
        }
        
        let alphasForViews:CGFloat = isText ? CGFloat(tipShownAlpha) : CGFloat(tipHideAlpha)
        let deltaYForContainer: CGFloat = isText ? CGFloat(tipChangeInYForContainer) : CGFloat(tipChangeInYForContainer).negated()
        let deltaYforscAndBillTFView: CGFloat = isText ? CGFloat(tipChangeInYForSCAndTF) : CGFloat(tipChangeInYForSCAndTF).negated()
        self.previousText = isText
        
        UIView.animate(withDuration: tipAnimationDuration, animations: { Void in
            
            self.tipAndTotalView.alpha = alphasForViews
            self.tipSegmentedControl.alpha = alphasForViews
            
            self.tipAndTotalView.frame.origin.y -= deltaYForContainer
            self.scAndBillTFView.frame.origin.y -= deltaYforscAndBillTFView
            
        }, completion: nil)
        
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        self.animateViewsIfPreviousText()
        
        let tipPercentages = [tipPercentage0, tipPercentage1, tipPercentage2]
        let billTotal = Double(self.totalBillTextField.text!) ?? 0
        let tip = billTotal*tipPercentages[self.tipSegmentedControl.selectedSegmentIndex]
        let total = billTotal + tip
        
        self.totalLabel.text = String(format: "%@%.2f", self.dollarSignForLocation, total)
        self.tipLabel.text = String(format: "%@%.2f", self.dollarSignForLocation, tip)
    }
	
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		var returnVal: Bool = true
		
		if (string == tipPeriodIdentifier && (self.totalBillTextField.text?.characters.contains(Character(tipPeriodIdentifier)))!) {
			returnVal = false
		}
		
		return returnVal
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
