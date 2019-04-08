//
//  FamilyMember+CoreDataProperties.swift
//  SnoreData
//
//  Created by student1 on 4/2/19.
//  Copyright © 2019 clara. All rights reserved.
//
//

import Foundation
import CoreData


extension FamilyMember {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FamilyMember> {
        return NSFetchRequest<FamilyMember>(entityName: "FamilyMember")
    }

    @NSManaged public var age: Int16
    @NSManaged public var name: String?
    @NSManaged public var sleepRecord: NSSet?

}

// MARK: Generated accessors for sleepRecord
extension FamilyMember {

    @objc(addSleepRecordObject:)
    @NSManaged public func addToSleepRecord(_ value: SleepRecord)

    @objc(removeSleepRecordObject:)
    @NSManaged public func removeFromSleepRecord(_ value: SleepRecord)

    @objc(addSleepRecord:)
    @NSManaged public func addToSleepRecord(_ values: NSSet)

    @objc(removeSleepRecord:)
    @NSManaged public func removeFromSleepRecord(_ values: NSSet)

}
