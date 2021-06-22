//
//  ViewNotesVC.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit
import CoreData

class ViewNotesVC: UIViewController {

    // swiftlint:disable force_cast
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // swiftlint:enable force_cast
    var notesTitle: String?
    var notesText: String?
    var notesBgColor: UIColor?

    @IBOutlet weak var viewTitle: UITextField!
    @IBOutlet weak var viewText: UITextView!
    @IBOutlet weak var editButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupToolBar()
    }
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

    func setupView() {
        viewTitle.text = notesTitle
        viewText.text = notesText
        view.backgroundColor = notesBgColor
        viewTitle.backgroundColor = notesBgColor
        viewText.backgroundColor = notesBgColor

        viewText.delegate = self
        viewTitle.delegate = self
    }
    func setupToolBar() {
        guard let custom = UINib(nibName: "CustomToolBar", bundle: nil).instantiate(withOwner: nil, options: nil).first as? CustomToolbar else {return}
        custom.sizeToFit()
        custom.customDelegate = self

        viewText.inputAccessoryView = custom
        viewTitle.inputAccessoryView = custom
    }
}

// MARK: - CustomToolbar Delegate

extension ViewNotesVC: CustomToolBarDelegate {
    func didSetBackgroundColor(view: Any, with color: UIColor) {
        self.view.backgroundColor = color
        viewTitle.backgroundColor = color
        viewText.backgroundColor = color
    }
}

// MARK: - UITextField Delegate

extension ViewNotesVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        editButton.title = "Save"
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewTitle.resignFirstResponder()
        return true
    }
}

// MARK: - UITextView Delegate

extension ViewNotesVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        editButton.title = "Save"
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            viewText.resignFirstResponder()
            return false
        }
        return true
    }
}

// MARK: - Data Manipulation Methods

extension ViewNotesVC {

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
