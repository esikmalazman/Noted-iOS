//
//  ViewController.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit
import CoreData

class BaseVC: UIViewController {
    // swiftlint:disable force_cast
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    // swiftlint:enable force_cast

    var arrayNotes = [Note]()

    @IBOutlet weak var baseTitle: UILabel!
    @IBOutlet weak var baseSubtitle: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        guard arrayNotes.count < 0  else {  return loadNotes()}

    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Receive notification if new items added
        // NotificationCenter.default.addObserver(self, selector: #selector(loadNotes), name: NSNotification.Name(rawValue: "loadTableView"), object: nil)
        tableView.register(UINib(nibName: "CustomNotedCell", bundle: nil), forCellReuseIdentifier: Constants.customCellIdentifierNote)
        loadNotes()
    }

    @IBAction func addButtonPressed(_ sender: UIButton) {

        // Navigate to NotesVC
        // guard let notesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesVC") as? NotesVC else {return}
        // self.navigationController?.pushViewController(notesVC, animated: true)
    }

    func setupUI() {
        navigationController?.navigationBar.tintColor = Constants.BrandColor.mainFontColor
        view.backgroundColor = Constants.BrandColor.bgColor
        tableView.backgroundColor = Constants.BrandColor.bgColor

        baseTitle.textColor = Constants.BrandColor.mainFontColor
        baseSubtitle.textColor = Constants.BrandColor.mainFontColor

        addButton.backgroundColor = Constants.BrandColor.mainFontColor
        addButton.tintColor = Constants.BrandColor.bgColor

        addButton.layer.shadowColor = UIColor.white.cgColor
        addButton.layer.shadowOpacity = 0.8

        addButton.layer.shadowOffset = CGSize(width: 1.3, height: 2)
        addButton.layer.cornerRadius = 30

    }
}

// MARK: - Table Delegate
extension BaseVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.goToNoteSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let destinationVC = segue.destination as? ViewNotesVC else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}

        destinationVC.notesTitle = arrayNotes[indexPath.row].title
        destinationVC.notesText = arrayNotes[indexPath.row].text
        destinationVC.notesBgColor = arrayNotes[indexPath.row].cellColor

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (_, _, _) in

            let notesToRemove = self.arrayNotes[indexPath.row]

            self.context.delete(notesToRemove)
            self.saveNotes()
            self.loadNotes()

        }
        return UISwipeActionsConfiguration(actions: [action])
    }

}

// MARK: - Table Datasource
extension BaseVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayNotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let listOfNotes = arrayNotes[indexPath.row]
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customCellIdentifierNote, for: indexPath) as! CustomNotedCell
        // swiftlint:enable force_cast

        cell.titleCell.text = listOfNotes.title
        cell.subtitleCell.text = listOfNotes.text
        cell.cellBg.backgroundColor = listOfNotes.cellColor
        return cell
    }
}

// MARK: - Data Manipulation Methods
extension BaseVC {

    func saveNotes() {
        do {
            try context.save()
        } catch {
            print("Error in saving context \(error.localizedDescription)")
        }
    }
    @objc func loadNotes() {

        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            arrayNotes = try context.fetch(request)
        } catch {
            print("Error load context \(error)")
        }
        tableView.reloadData()
    }

}
