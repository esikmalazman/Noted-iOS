//
//  ViewNotesVC.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit

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

    }
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        editButton.title = "Save"
        // TODO: Add save function context here
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

}
// MARK: - UITextField Delegate
extension ViewNotesVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewTitle.resignFirstResponder()
        return true
    }
}

extension ViewNotesVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            viewText.resignFirstResponder()
            return false
        }
        return true
    }
}

extension ViewNotesVC {
    func saveNotes(){
        do{
            try context.save()
        } catch {
            print("Error saving context \(error.localizedDescription)")
        }
    }
}
