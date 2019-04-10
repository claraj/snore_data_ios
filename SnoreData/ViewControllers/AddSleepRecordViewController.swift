//
//  AddSleepRecordViewController.swift
//  SnoreData
//
//  Created by student1 on 4/2/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import UIKit

class AddSleepRecordViewController: UIViewController {
    
    @IBOutlet var hoursInput: UITextField!
    @IBOutlet var datePicker: UIDatePicker!
    
    var delegate: SleepRecordDelegate?
    
    var familyMember: FamilyMember?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let familyMember = familyMember else {
            preconditionFailure("Family Member must be set")
        }

        // Can't add a sleep record for the future
        datePicker.maximumDate = Date()
        navigationItem.title = "Add Sleep Record for \(familyMember.name!)"
    }

    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let hours = Float((hoursInput?.text)!) else {
            showAlert(title: "Error", message: "Enter a number of hours")
            return }
        
        if hours < 0 || hours > 24 {
            showAlert(title: "Error", message: "Enter a number of hours between 0 and 24")
            return
        }
        
        let date = datePicker.date
        
        delegate!.newSleepRecord(familyMember: familyMember!,  hours: hours, date: date)
        self.navigationController?.popViewController(animated: true)
    }
}
