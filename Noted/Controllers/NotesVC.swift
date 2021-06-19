//
//  NotesVC.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit
import CoreData

class NotesVC: UIViewController {

    // swiftlint:disable force_cast
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // swiftlint:enable force_cast

    @IBOutlet weak var notesTitle: UITextField!
    @IBOutlet weak var notesText: UITextView!

    var selectColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolBar()
        notesTitle.becomeFirstResponder()
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {

        let newNotes = Note(context: context)
        newNotes.title = notesTitle.text
        newNotes.text = notesText.text
        newNotes.cellColor = selectColor

        print("New Notes Saved")
        saveNotes()

        // Notify baseVC that new notes added
        NotificationCenter.default.post(name: NSNotification.Name("loadTableView"), object: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }

    func setupToolBar() {
        guard let custom = UINib(nibName: "CustomToolBar", bundle: nil).instantiate(withOwner: nil, options: nil).first as? CustomToolbar else {return}
        custom.sizeToFit()
        custom.customDelegate = self

        notesTitle.inputAccessoryView = custom
        notesText.inputAccessoryView = custom
    }
}

// MARK: - Data Manipulation
extension NotesVC {
    func saveNotes() {

        do {
            try context.save()

        } catch {
            print("Error saving context \(error)")
        }
    }
}

// MARK: - Custom ToolBar Delegate
extension NotesVC: CustomToolBarDelegate {

    func didSetBackgroundColor(view: Any, with color: UIColor) {
        selectColor = color
        notesTitle.backgroundColor = color
        notesText.backgroundColor = color
        self.view.backgroundColor = color
    }

}
