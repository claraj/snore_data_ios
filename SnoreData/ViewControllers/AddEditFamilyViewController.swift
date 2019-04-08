//
//  AddEditFamilyViewController.swift
//  SnoreData
//
//  Created by student1 on 4/2/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import UIKit

class AddEditFamilyMemberViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    
    var familyMember: FamilyMember?
    
    var familyDelegate: FamilyMemberModifiedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "Add/Edit Family Member"
        // TODO set this to add or edit, as appropriate
        
        if let f = familyMember {
            nameTextField.text = f.name
            ageTextField.text = "\(f.age)"
        }
        
    }
    
    
    @IBAction func save(_ sender: Any) {
        
        // first, assume adding
        guard let name = nameTextField.text else { return }
        guard let ageStr = ageTextField.text else { return }
        
        if let age = Int16(ageStr) {

            if let existingFamilyMember = familyMember {
                existingFamilyMember.age = age
                existingFamilyMember.name = name
                familyDelegate?.modifiedfamilyMember(familyMember: existingFamilyMember)
            }
                
            else {
                familyDelegate?.newfamilyMember(name: name, age: age)
            }
            
            // go back
            navigationController?.popViewController(animated: true)

            
        }
        
        
    }
    
    
}
