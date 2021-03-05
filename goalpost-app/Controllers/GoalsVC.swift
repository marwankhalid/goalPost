//
//  GoalsVC.swift
//  goalpost-app
//
//  Created by Marwan Khalid on 11/3/18.
//  Copyright © 2018 Marwan Khalid. All rights reserved.
//

import UIKit
import CoreData
var appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalsVC: UIViewController {
    
    var goals: [Goal] = []

    @IBOutlet weak var tabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabelView.delegate = self
        tabelView.dataSource = self
        tabelView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        tabelView.reloadData()
    }
    func fetchCoreDataObjects (){
        self.fetch { (complete) in
            if complete {
                if goals.count >= 1 {
                    tabelView.isHidden = false
                }
                else {
                    tabelView.isHidden = true
                }
            }
        }
    }
    
    @IBAction func addGoalButton(_ sender: Any) {
        guard let createGoalVC = storyboard?.instantiateViewController(withIdentifier: "CreateGoalVC") else {
            return
        }
        presentDetail(createGoalVC)
        
    }
    
}

extension GoalsVC:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell") as? GoalCellTableViewCell else {
           return UITableViewCell()
        }
        let goal = goals[indexPath.row]
        cell.configurecell(goal: goal)
        return cell
    }
    
    // functions for delete data from CoreData
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        // for delete table row cell
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (rowAction, indexPath) in
            self.remove(atIndexpath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
            // for add button
            let AddAction = UITableViewRowAction(style: .normal, title: "ADD", handler: { (rowAction, indexPath) in
                self.setProgress(atindexpath: indexPath)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
            AddAction.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            deleteAction.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        
        return [deleteAction,AddAction]
        
    }
}
extension GoalsVC {
    
    func setProgress (atindexpath indexpath:IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let chosenGoal = goals[indexpath.row]
        
        if chosenGoal.goalProgress < chosenGoal.goalCompletionValue {
            chosenGoal.goalProgress = chosenGoal.goalProgress + 1
        }
        else {
            return
        }
        
        do {
            try managedContext.save()
        }
        catch {
            debugPrint("Could not save data \(error.localizedDescription)")
        }
        
    }
    func remove (atIndexpath indexPath: IndexPath){
        guard let manageContext = appDelegate?.persistentContainer.viewContext else {return}
        
        manageContext.delete(goals[indexPath.row])
        
        do {
            try manageContext.save()
            print("Goal Successfully Remove")
        }
        catch{
            debugPrint("Could not Remove \(error.localizedDescription)")
        }
    }
    
    
    
    func fetch(completion:(_ complete: Bool) -> ()) {
    guard let manageContext = appDelegate?.persistentContainer.viewContext else {return}
    
    let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
    
        do {
            goals = try manageContext.fetch(fetchRequest)
            completion(true)
            print("Successfully fetch data!")
        }
        catch {
            debugPrint("Can't Reload Data :\(error.localizedDescription)")
            completion(false)
        }
    }
}

