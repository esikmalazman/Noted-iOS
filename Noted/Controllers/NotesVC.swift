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

    var selectColor: UIColor = Constants.BrandColor.bgColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolBar()
        setupUI()
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {

        // Notify baseVC that new notes added
        // NotificationCenter.default.post(name: NSNotification.Name("loadTableView"), object: nil)
        addNewNotes()
        SoundManager.shared.playSound(soundFileName: Constants.SoundFile.saveNotes)
        print("New Notes Saved")
        saveNotes()
        self.navigationController?.popToRootViewController(animated: true)
    }
    func setupUI() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = selectColor
        view.backgroundColor = selectColor
        notesText.backgroundColor = selectColor
        notesTitle.delegate = self
        notesText.delegate = self
    }
    func setupToolBar() {
        guard let custom = UINib(nibName: "CustomToolBar", bundle: nil).instantiate(withOwner: nil, options: nil).first as? CustomToolbar else {return}
        custom.sizeToFit()
        custom.customDelegate = self

        notesTitle.inputAccessoryView = custom
        notesText.inputAccessoryView = custom
    }
    func addNewNotes() {
        let newNotes = Note(context: context)
        newNotes.title = notesTitle.text
        newNotes.text = notesText.text
        newNotes.cellColor = selectColor
    }
}

// MARK: - Data Manipulation

extension NotesVC {
    func saveNotes() {

        do {
            try context.save()

        } catch {
            print("Error saving context \(error.localizedDescription)")
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
        SoundManager.shared.playSound(soundFileName: Constants.SoundFile.tapToolBarColor)
    }
}

// MARK: - UITextFieldDelegate

extension NotesVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "Title" {
            textField.text = ""
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - UITextViewDelegate

extension NotesVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type something.."{
            textView.text = ""
        }
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
