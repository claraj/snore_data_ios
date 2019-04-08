//
//  FamilyMemberModifiedDelegate.swift
//  SnoreData
//
//  Created by student1 on 4/2/19.
//  Copyright © 2019 clara. All rights reserved.
//

import Foundation

protocol FamilyMemberModifiedDelegate {
    func newfamilyMember(name: String, age: Int16) -> Void
    func modifiedfamilyMember(familyMember: FamilyMember) -> Void
}
