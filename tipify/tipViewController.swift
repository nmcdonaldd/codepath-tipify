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
    private var previousText:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tipAndTotalContainerView.alpha = 0.0
        self.tipSegmentedControl.alpha = 0.0
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
        self.previousText = isText
        
        print("Animating: \(alphasForViews)")
        
        UIView.animate(withDuration: 0.2, animations: { Void in
            
            self.tipAndTotalContainerView.alpha = alphasForViews
            self.tipAndTotalContainerView.alpha = alphasForViews
            
        }, completion: nil)
        
    }
    
    @IBAction func calculateTip(_ sender: AnyObject) {
        self.animateViewsIfPreviousText()
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
