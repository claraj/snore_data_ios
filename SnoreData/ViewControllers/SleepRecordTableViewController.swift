//
//  SleepRecordTableViewController.swift
//  SnoreData
//
//  Created by student1 on 4/2/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class SleepRecordViewController: UITableViewController, NSFetchedResultsControllerDelegate, NewSleepRecordDelegate {
    
    var familyMember: FamilyMember?
    var managedContext: NSManagedObjectContext?
    var fetchedSleepRecordsController: NSFetchedResultsController<SleepRecord>?

    
    let dateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
        df.dateStyle = .short
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(familyMember != nil)
        
        let familyPredicate = NSPredicate(format: "familyMember == %@", familyMember!)

    
       // let predicate = NSPredicate(format: "familyMember == %@", familyMember!)
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false) // most recent at the top

        let sleepRecordsFetch = NSFetchRequest<SleepRecord>(entityName: "SleepRecord")
        sleepRecordsFetch.sortDescriptors = [sortDescriptor]
        sleepRecordsFetch.predicate = familyPredicate
        
        fetchedSleepRecordsController = NSFetchedResultsController(fetchRequest: sleepRecordsFetch, managedObjectContext: managedContext!, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedSleepRecordsController?.delegate = self
        
        do {
            try fetchedSleepRecordsController?.performFetch()
        } catch {
            print("error fetching sleep records \(error)")
        }
        
    }
    
    func sleepRecord(familyMember: FamilyMember, hours: Float, date: Date) {
        
        let sleepRecord = SleepRecord(context: managedContext!)
        sleepRecord.hours = hours
        sleepRecord.date = date
        sleepRecord.familyMember = familyMember
        
        
        do {
            try sleepRecord.validateForInsert()
            print("valid!")
            try managedContext!.save()
        } catch {
            print("Error saving new sleep record because \(error)")
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationItem.title = "Sleep Records"
    }
    
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        
        print("CHANGED CONTENT")
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let objects = fetchedSleepRecordsController!.fetchedObjects{
            return objects.count
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SleepRecordTableCell")!
        
        let sleepRecord = fetchedSleepRecordsController?.fetchedObjects![indexPath.row]
        
        cell.textLabel?.text = dateFormatter.string(from: sleepRecord!.date!) 
        cell.detailTextLabel!.text = "\(sleepRecord!.hours) hours"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSleepRecord" {
            let addRecordController = segue.destination as! AddSleepRecordViewController
            
            addRecordController.delegate = self
            addRecordController.familyMember = familyMember!
            

        }
    }


    
}
