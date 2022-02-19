//
//  ViewNotesVC.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit
import CoreData

final class NotesDetailsVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var viewTitle: UITextField!
    @IBOutlet weak var viewText: UITextView!
    @IBOutlet weak var editButton: UIBarButtonItem!

    // MARK: - Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var notesTitle: String?
    var notesText: String?
    var notesBgColor: UIColor?
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupToolBar()
    }
    // MARK: - Actions
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        if editButton.title == "Edit" {
            editButton.title = "Save"
            viewTitle.becomeFirstResponder()
        } else {
            editButton.title = "Edit"
            updateNotes(with: notesTitle!, newTitle: viewTitle.text!, newText: viewText.text, newColor: view.backgroundColor!)
            SoundManager.shared.playSound(soundFileName: Constants.SoundFile.saveNotes)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

// MARK: - CustomToolbar Delegate
extension NotesDetailsVC: CustomToolBarDelegate {
    func didSetBackgroundColor(view: Any, with color: UIColor) {
        self.view.backgroundColor = color
        viewTitle.backgroundColor = color
        viewText.backgroundColor = color
    }
}

// MARK: - UITextField Delegate
extension NotesDetailsVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editButton.title = "Save"
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewTitle.resignFirstResponder()
        return true
    }
}

// MARK: - UITextView Delegate
extension NotesDetailsVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        editButton.title = "Save"
    }
}

// MARK: - Data Manipulation Methods
extension NotesDetailsVC {

    func updateNotes(with title: String, newTitle: String, newText: String, newColor: UIColor) {
        // attributesName, arguements
        let predicate = NSPredicate(format: "title = %@ ", title)
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        request.predicate = predicate

        do {

            let retrieveResult = try context.fetch(request)
            let result = retrieveResult.first
            // newValue for attributes
            result?.setValue(newTitle, forKey: "title")
            result?.setValue(newText, forKey: "text")
            result?.setValue(newColor, forKey: "cellColor")
            saveNotes()

        } catch {
            print("Error load context : \(error.localizedDescription)")
        }
    }

    func saveNotes() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error.localizedDescription)")
        }
    }
}

// MARK: - Private methods
extension NotesDetailsVC {
    private func setupView() {
        viewTitle.text = notesTitle
        viewText.text = notesText

        viewTitle.textColor = Constants.BrandColor.notesColor
        viewText.textColor = Constants.BrandColor.notesColor

        view.backgroundColor = notesBgColor
        viewTitle.backgroundColor = notesBgColor
        viewText.backgroundColor = notesBgColor

        viewText.delegate = self
        viewTitle.delegate = self
    }

    private func setupToolBar() {
        guard let custom = UINib(nibName: XIBName.CustomToolBar.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil).first as? CustomToolbar else {return}
        custom.sizeToFit()
        custom.customDelegate = self

        viewText.inputAccessoryView = custom
        viewTitle.inputAccessoryView = custom
    }
}

#warning("Navbar tint not follow selected color")
