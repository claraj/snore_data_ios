//
//  SleepRecord+CoreDataProperties.swift
//  SnoreData
//
//  Created by student1 on 4/2/19.
//  Copyright © 2019 clara. All rights reserved.
//
//

import Foundation
import CoreData


extension SleepRecord {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SleepRecord> {
        return NSFetchRequest<SleepRecord>(entityName: "SleepRecord")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var hours: Float
    @NSManaged public var familyMember: FamilyMember?

}
