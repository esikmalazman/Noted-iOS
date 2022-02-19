//
//  Constants.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit

struct Constants {

    static var accessObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    static let cellIdentifierNote = "noteCell"
    static let customCellIdentifierNote = "customNoteCell"
    static let goToNoteSegue = "goToNote"

    struct BrandColor {
        static let bgColor = UIColor(named: "bgColor")
        static let mainFontColor = UIColor(named: "mainFontColor")
        static let notesColor = UIColor(named: "notesColor")
        static let subtitleNotesColor = UIColor(named: "notesSubtitleColor")
        static let cursorColor = UIColor(named: "cursorColor")
    }

    struct ToolBarColor {
        static let purple = #colorLiteral(red: 0.6352941176, green: 0.6078431373, blue: 0.9960784314, alpha: 1)
        static let blue = #colorLiteral(red: 0.4549019608, green: 0.7254901961, blue: 1, alpha: 1)
        static let green = #colorLiteral(red: 0.3333333333, green: 0.937254902, blue: 0.768627451, alpha: 1)
        static let yellow = #colorLiteral(red: 1, green: 0.9176470588, blue: 0.6549019608, alpha: 1)
        static let red = #colorLiteral(red: 0.9803921569, green: 0.6941176471, blue: 0.6274509804, alpha: 1)
    }

    struct SoundFile {
        static let createNotes = "create-notes-swoosh-sound"
        static let deleteNotes = "delete-notes-swoosh-sound"
        static let saveNotes = "save-notes-bell-sound"
        static let tapToolBarColor = "tap-toolbar-color-sound"
    }
}
