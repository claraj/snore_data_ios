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
    
    var delegate: NewSleepRecordDelegate?
    
    var familyMember: FamilyMember?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Can't add a sleep record for the future
        datePicker.maximumDate = Date()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "Add Sleep Record"
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        guard let hours = Float((hoursInput?.text)!) else {
            return }
        
        let date = datePicker.date
        
        delegate!.sleepRecord(familyMember: familyMember!,  hours: hours, date: date)
        self.navigationController?.popViewController(animated: true)
        
    }
}
