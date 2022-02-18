//
//  NotesVC.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit
import CoreData

final class CreateNotesVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var notesTitle: UITextField!
    @IBOutlet weak var notesText: UITextView!
    @IBOutlet weak var saveBtn: UIBarButtonItem!

    // MARK: - Variables
    var selectColor: UIColor = Constants.BrandColor.bgColor!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupToolBar()
        setupUI()
    }
    // MARK: - Actions
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        // Notify baseVC that new notes added
        // NotificationCenter.default.post(name: NSNotification.Name("loadTableView"), object: nil)
        addNewNotes()
        SoundManager.shared.playSound(soundFileName: Constants.SoundFile.saveNotes)
        print("New Notes Saved")
        saveNotes()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

// MARK: - Data Manipulation
extension CreateNotesVC {
    func saveNotes() {

        do {
            try context.save()

        } catch {
            print("Error saving context \(error.localizedDescription)")
        }
    }
}

// MARK: - Custom ToolBar Delegate
extension CreateNotesVC: CustomToolBarDelegate {

    func didSetBackgroundColor(view: Any, with color: UIColor) {
        selectColor = color

        notesTitle.backgroundColor = color
        // Change text color when color notes set
        notesTitle.textColor = .black

        notesText.backgroundColor = color
        notesText.textColor = .black

        self.view.backgroundColor = color
        saveBtn.isEnabled = true
        SoundManager.shared.playSound(soundFileName: Constants.SoundFile.tapToolBarColor)
    }
}

// MARK: - UITextFieldDelegate
extension CreateNotesVC: UITextFieldDelegate {

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
extension CreateNotesVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Type something.."{
            textView.text = ""
        }
    }
}

extension CreateNotesVC {
    private func setupUI() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.backgroundColor = selectColor
        view.backgroundColor = selectColor

        notesText.backgroundColor = selectColor
        notesText.delegate = self
        notesText.isScrollEnabled = true

        notesTitle.delegate = self

        saveBtn.isEnabled = false

        // Change the appearance of cursor in textfield
        UITextField.appearance().tintColor = Constants.BrandColor.cursorColor
        UITextView.appearance().tintColor = Constants.BrandColor.cursorColor
    }
    private func setupToolBar() {
        guard let custom = UINib(nibName: "CustomToolBar", bundle: nil).instantiate(withOwner: nil, options: nil).first as? CustomToolbar else {return}
        custom.sizeToFit()
        custom.customDelegate = self

        notesTitle.inputAccessoryView = custom
        notesText.inputAccessoryView = custom
    }
    private func addNewNotes() {
        let newNotes = Note(context: context)
        newNotes.title = notesTitle.text
        newNotes.text = notesText.text
        newNotes.cellColor = selectColor
    }
}
