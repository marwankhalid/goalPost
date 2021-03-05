//
//  GoalCellTableViewCell.swift
//  goalpost-app
//
//  Created by Marwan Khalid on 11/3/18.
//  Copyright © 2018 Marwan Khalid. All rights reserved.
//

import UIKit

class GoalCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var GoalDescription: UILabel!
    @IBOutlet weak var GoalType: UILabel!
    @IBOutlet weak var GoalProgress: UILabel!
    @IBOutlet weak var completionView: UIView!
    
    func configurecell (goal:Goal) {
        self.GoalDescription.text = goal.goalDescription
        self.GoalType.text = goal.goalType
        self.GoalProgress.text = String(goal.goalProgress)
        if goal.goalProgress == goal.goalCompletionValue {
            completionView.isHidden = false
        }
        else {
            completionView.isHidden = true
        }
    }
}
