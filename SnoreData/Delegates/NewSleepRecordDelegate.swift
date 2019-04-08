//
//  NewSleepRecordDelegate.swift
//  SnoreData
//
//  Created by student1 on 4/2/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation

protocol NewSleepRecordDelegate {
    func sleepRecord(familyMember: FamilyMember, hours: Float, date: Date) -> Void
}
