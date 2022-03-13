//
//  ViewNotesVC.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit

#warning("Navbar tint not follow selected color")
final class NotesDetailsVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var viewTitle: UITextField!
    @IBOutlet weak var viewText: UITextView!
    @IBOutlet weak var editButton: UIBarButtonItem!

    // MARK: - Variables
    var notesTitle: String?
    var notesText: String?
    var notesBgColor: String?
    var selectedNote: Note?

    private let presenter = NotesDetailsPresenter()
    private let analytics = FirebaseAnalyticsManager(engine: FirebaseAnalyticsEngine())

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupToolBar()
        presenter.delegate = self
        presenter.fetchNote(withTitle: notesTitle!)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        analytics.log(.noteDetailsScreenViewed)
    }
    // MARK: - Actions
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        presenter.didTapEditNotes()
    }

    func updateNotes(newTitle: String, newText: String, newColor: UIColor) {
        selectedNote?.title = newTitle
        selectedNote?.text = newText
        selectedNote?.cellColor = newColor
        selectedNote?.noteColor = newColor.toHex

        presenter.saveNotes(selectedNote!)
        analytics.log(.noteSaved)
    }
}

// MARK: - CustomToolbar Delegate
extension NotesDetailsVC: CustomToolBarDelegate {
    func didSetBackgroundColor(view: Any, with color: UIColor) {
        analytics.log(.colorSelected(selected: true))
        self.view.backgroundColor = color
        viewTitle.backgroundColor = color
        viewText.backgroundColor = color
    }
}

// MARK: - UITextField Delegate
extension NotesDetailsVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        analytics.log(.textAdded)
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

// MARK: - Private methods
extension NotesDetailsVC {
    private func setupView() {
        viewTitle.text = notesTitle
        viewText.text = notesText

        viewTitle.textColor = Constants.BrandColor.notesColor
        viewText.textColor = Constants.BrandColor.notesColor

        view.backgroundColor = UIColor(hex: notesBgColor!)
        viewTitle.backgroundColor = UIColor(hex: notesBgColor!)
        viewText.backgroundColor = UIColor(hex: notesBgColor!)

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

// MARK: - NotesDetailsPresenterDelegate
extension NotesDetailsVC: NotesDetailsPresenterDelegate {
    func presentFetchForSelectedNote(_ NotesDetailsPresenter: NotesDetailsPresenter, data: Note) {
        selectedNote = data
    }

    func presentActionForEditNotes(_ NotesDetailsPresenter: NotesDetailsPresenter) {
        if editButton.title == "Edit" {
            editButton.title = "Save"
            viewTitle.becomeFirstResponder()
        } else {
            editButton.title = "Edit"
            updateNotes(newTitle: viewTitle.text!, newText: viewText.text, newColor: view.backgroundColor!)
            SoundManager.shared.playSound(soundFileName: Constants.SoundFile.saveNotes)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
