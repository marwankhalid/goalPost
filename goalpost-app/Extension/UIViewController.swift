//
//  UIViewController.swift
//  goalpost-app
//
//  Created by Marwan Khalid on 11/3/18.
//  Copyright © 2018 Marwan Khalid. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ VCtoPresent: UIViewController) {
        let tranition = CATransition()
        tranition.duration = 0.3
        tranition.type = CATransitionType.fade
        tranition.subtype = CATransitionSubtype.fromRight
        self.view.window?.layer.add(tranition, forKey: kCATransition)
        
        present(VCtoPresent, animated: false)
    
    }
    func HomeVC(_ HomeVCtoPresent: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        
        guard let HomeVCpresent = presentedViewController else {return}
        HomeVCpresent.dismiss(animated: false) {
            self.view.window?.layer.add(transition,forKey: kCATransition)
            self.present(HomeVCtoPresent, animated: false, completion: nil)
        }
    }
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.fade
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
}
