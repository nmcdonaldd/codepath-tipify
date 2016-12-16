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
    @IBOutlet weak var tipAndTotalContainerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Make the textfield the first responder.
        totalBillTextField.becomeFirstResponder()
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        
        if totalBillTextField.text != "" {
            self.tipSegmentedControl.isHidden = false
            self.tipAndTotalContainerView.isHidden = false
        } else {
            
        }
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
