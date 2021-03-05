//
//  CreateGoalVC.swift
//  goalpost-app
//
//  Created by Marwan Khalid on 11/3/18.
//  Copyright © 2018 Marwan Khalid. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController,UITextViewDelegate{
    
    @IBOutlet weak var textview: UITextView!
    @IBOutlet weak var shorttermbtn: UIButton!
    @IBOutlet weak var longtermbtn: UIButton!
    @IBOutlet weak var nextbtn: UIButton!
    
    var goal :GoalType = .shortterm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextbtn.bindToKeyboard()
        shorttermbtn.setSelectedColor()
        longtermbtn.setDeselectedColor()
        textview.delegate = self
        
    }
    @IBAction func shorttermbtnpressed(_ sender: Any) {
        goal = .shortterm
        shorttermbtn.setSelectedColor()
        longtermbtn.setDeselectedColor()
        
    }
    @IBAction func longtermbtnpressed(_ sender: Any) {
        goal = .longterm
        longtermbtn.setSelectedColor()
        shorttermbtn.setDeselectedColor()
    }
    @IBAction func nextbtnpressed(_ sender: Any) {
        if textview.text != "" && textview.text != "What is Your Goal?"{
        guard let finishVC = storyboard?.instantiateViewController(withIdentifier: "finishVC") as? FinishVC else { return }
        finishVC.initData(description: textview.text!, Type: goal)
            //present(finishVC, animated: false, completion: nil)
            
       presentingViewController?.HomeVC(finishVC)
            
        }
    }
    @IBAction func backbtnpressed(_ sender: Any) {
        dismissDetail()
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textview.text = ""
        textview.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    
}
