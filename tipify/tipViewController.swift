//
//  tipViewController.swift
//  tipify
//
//  Created by Nick McDonald on 12/16/16.
//  Copyright © 2016 Nick McDonald. All rights reserved.
//

import UIKit

class tipViewController: UIViewController {

    @IBOutlet weak var totalBillTextField: UITextField!
    @IBOutlet weak var scAndBillTFView: UIView!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tipAndTotalView: UIView!
    private var previousText:Bool = false
    private var previousShownKeyboard = false
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShown(notification:)), name: .UIKeyboardWillShow, object: nil)

        // Do any additional setup after loading the view.
        self.tipAndTotalView.alpha = 0.0
        self.tipSegmentedControl.alpha = 0.0
    }
    
    func keyboardShown(notification: Notification) {
        
        if !previousShownKeyboard {
            if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                self.tipAndTotalView.frame.origin.y = keyboardSize.minY - keyboardSize.height
                print("Origin.y: \(self.tipAndTotalView.frame.origin.y)")
            }
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
        
        let alphasForViews:CGFloat = isText ? 1.0 : 0.0
        let deltaYForContainer: CGFloat = isText ? 175 : -175
        let deltaYforscAndBillTFView: CGFloat = isText ? 100 : -100
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
        
        let tipPercentages = [0.15, 0.2, 0.25]
        let billTotal = Double(self.totalBillTextField.text!) ?? 0
        let tip = billTotal*tipPercentages[self.tipSegmentedControl.selectedSegmentIndex]
        let total = billTotal + tip
        
        self.totalLabel.text = String(format: "$%.2f", total)
        self.tipLabel.text = String(format: "$%.2f", tip)
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
