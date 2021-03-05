//
//  FinishVC.swift
//  goalpost-app
//
//  Created by Marwan Khalid on 11/3/18.
//  Copyright © 2018 Marwan Khalid. All rights reserved.
//

import UIKit

class FinishVC: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var pointsTextfield: UITextField!
    @IBOutlet weak var createGoalbtn: UIButton!
    var goaldescription: String!
    var goaltype: GoalType!
    
    func initData (description: String, Type: GoalType){
        self.goaldescription = description
        self.goaltype = Type
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pointsTextfield.delegate = self
        createGoalbtn.bindToKeyboard()
    }
    
    @IBAction func createGoalbtnwasPressed(_ sender: Any) {
        if pointsTextfield.text != "" {
            save { (complete) in
                if complete {
                    dismissDetail()
                }
            }
        }
        
    }
    @IBAction func backbtnwasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    func save(completion: (_ finished:Bool)->()){
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return }
        let goal = Goal(context: managedContext)
        
        goal.goalDescription = goaldescription
        goal.goalType = goaltype.rawValue
        goal.goalCompletionValue = Int32(pointsTextfield.text!)!
        goal.goalProgress = Int32(0)
        
        do {
            try managedContext.save()
            completion(true)
            print("data successfully save")
        }
        catch {
            debugPrint("Could Not save \(error.localizedDescription)")
            completion(false)
        }
    }
    
}
