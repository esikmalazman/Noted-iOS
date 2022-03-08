//
//  Note+CoreDataProperties.swift
//  Noted
//
//  Created by Ikmal Azman on 08/03/2022.
//
//

import Foundation
import CoreData
import UIKit.UIColor

extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var cellColor: UIColor?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var noteColor: String?

}

extension Note : Identifiable {

}
