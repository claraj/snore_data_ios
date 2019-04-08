//
//  ViewController.swift
//  SnoreData
//
//  Created by student1 on 4/2/19.
//  Copyright © 2019 clara. All rights reserved.
//

import UIKit
import CoreData

class FamilyTableViewController: UITableViewController, FamilyMemberModifiedDelegate, NSFetchedResultsControllerDelegate {

    var managedContext: NSManagedObjectContext?
    
    //var familyMemberObjects: [FamilyMember] = []
    var fetchResultsController: NSFetchedResultsController<FamilyMember>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // sort descriptors are required
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let familyFetch = NSFetchRequest<FamilyMember>(entityName: "FamilyMember")
        familyFetch.sortDescriptors = [sortDescriptor]

        fetchResultsController = NSFetchedResultsController(fetchRequest: familyFetch, managedObjectContext: managedContext!, sectionNameKeyPath: nil, cacheName: nil)

        fetchResultsController?.delegate = self
        
        do {
            try fetchResultsController?.performFetch()
        } catch {
            print("Error fetching family members \(error)")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        print("CHANGED CONTENT")
       // print(controller.fetchedObjects)
        
        //familyMemberObjects = controller.fetchedObjects as! [FamilyMember]
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (fetchResultsController?.fetchedObjects!.count)!
//        return familyMemberObjects.count  // todo return number of family members
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // let familyMember = familyMemberObjects[indexPath.row]
        
        let familyMember = fetchResultsController?.fetchedObjects![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyTableCell")!
        cell.textLabel?.text = familyMember!.name
        cell.detailTextLabel?.text = "\(familyMember!.age) years old"
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        print(segue.identifier)
        switch segue.identifier {
        case "editFamilyMember":
            
            print("edit")
            
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            
            print("selected index path ")
            let row = indexPath.row
            let selectedFamilyMember =  fetchResultsController?.fetchedObjects![row]
            let destination = segue.destination as! AddEditFamilyMemberViewController
            destination.familyMember = selectedFamilyMember
            destination.familyDelegate = self
        
        case "addFamilyMember":
            print("add")
            
            let destination = segue.destination as! AddEditFamilyMemberViewController
           // destination.familyMember = selectedFamilyMember
            destination.familyDelegate = self
            
        case "showFamilyMemberSleepRecords":
            print("show")
            // who was selected?

            let selectedRow = tableView.indexPathForSelectedRow!.row
            let familyMember = fetchResultsController!.fetchedObjects![selectedRow]

            let destination = segue.destination as! SleepRecordViewController
            destination.managedContext = managedContext
            destination.familyMember = familyMember
            
        default:
            print("What type of segue is this??")
        }
    }

    
    func newfamilyMember(name: String, age: Int16) {
        
        print("NEW FAMILY MEMBER")
        
        let familyEntity = FamilyMember(context: managedContext!)
        familyEntity.name = name
        familyEntity.age = age
        
        
        do {
            try familyEntity.validateForInsert()
            print("IT IS VALID")
            try managedContext!.save()
        } catch {
            managedContext!.reset()
            print("error adding new \(error)")
        }
        
    }
    
    
    func modifiedfamilyMember(familyMember: FamilyMember) {

        print("MOD FAM MEMBER")
        
        do {
            try familyMember.validateForUpdate()
            try managedContext!.save()
        } catch {
            managedContext!.reset()
            print("Error saving, \(error)")
        }
        
    }
    
}

