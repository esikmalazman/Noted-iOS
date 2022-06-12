//
//  Note+CoreDataProperties.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//
//

import Foundation
import CoreData
import UIKit.UIColor

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var text: String?
    @NSManaged public var cellColor: UIColor?

}

extension Note: Identifiable {

}
