//
//  ViewController.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit

final class HomeNotesVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var baseTitle: UILabel!
    @IBOutlet weak var baseSubtitle: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    private var arrayNotes = [Note]()
    private let presenter = HomeNotesPresenter()

    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        guard arrayNotes.count < 0  else {return presenter.reloadNotes()}
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.delegate = self
        // Receive notification if new items added
        // NotificationCenter.default.addObserver(self, selector: #selector(loadNotes), name: NSNotification.Name(rawValue: "loadTableView"), object: nil)
        presenter.reloadNotes()
    }


    @IBAction func addButtonPressed(_ sender: UIButton) {
        SoundManager.shared.playSound(soundFileName: Constants.SoundFile.createNotes)
        // Navigate to NotesVC
        // guard let notesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesVC") as? NotesVC else {return}
        // self.navigationController?.pushViewController(notesVC, animated: true)
    }
    
    func deleteNotes(at indexPath : IndexPath, with rowAnimation : UITableView.RowAnimation = .left) {
        SoundManager.shared.playSound(soundFileName: Constants.SoundFile.deleteNotes)
        arrayNotes.remove(at: indexPath.row)
        
        DispatchQueue.main.async {
            self.tableView.deleteRows(at: [indexPath], with: rowAnimation)
        }
    }
}

// MARK: - Table Delegate
extension HomeNotesVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.goToNoteSegue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        SoundManager.shared.playSound(soundFileName: Constants.SoundFile.createNotes)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let destinationVC = segue.destination as? NotesDetailsVC else {return}
        guard let indexPath = tableView.indexPathForSelectedRow else {return}

        destinationVC.notesTitle = arrayNotes[indexPath.row].title
        destinationVC.notesText = arrayNotes[indexPath.row].text
        destinationVC.notesBgColor = arrayNotes[indexPath.row].noteColor
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
 
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let objectToDelete = arrayNotes[indexPath.row]
            presenter.deleteNotes(objectToDelete)
            deleteNotes(at: indexPath)
        }
    }
}

// MARK: - Table Datasource
extension HomeNotesVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrayNotes.isEmpty {
            tableView.setEmptyMessage("You haven't created any notes yet", Constants.BrandColor.mainFontColor ?? .black)
        } else {
            self.tableView.restore()
        }
        return arrayNotes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listOfNotes = arrayNotes[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.customCellIdentifierNote, for: indexPath) as! CustomNotedCell
        cell.configureCell(withData: listOfNotes)

        tableView.backgroundView = nil

        return cell
    }
}

// MARK: - Private methods
extension HomeNotesVC {
    private func setupUI() {

        setupTableView()
        setupAddButon()

        navigationController?.navigationBar.tintColor = Constants.BrandColor.mainFontColor
        view.backgroundColor = Constants.BrandColor.bgColor

        baseTitle.textColor = Constants.BrandColor.mainFontColor
        baseSubtitle.textColor = Constants.BrandColor.mainFontColor
    }

    private func setupTableView() {
        tableView.register(UINib(nibName: XIBName.CustomNotedCell.rawValue, bundle: nil), forCellReuseIdentifier: Constants.customCellIdentifierNote)
        tableView.backgroundColor = Constants.BrandColor.bgColor
    }

    private func setupAddButon() {
        addButton.backgroundColor = Constants.BrandColor.mainFontColor
        addButton.tintColor = Constants.BrandColor.bgColor
        addButton.layer.cornerRadius = 30
    }
}

// MARK: - HomeNotesPresenterDelegate
extension HomeNotesVC: HomeNotesPresenterDelegate {
    func presentFetchNotesWhenSuccess(_ HomeNotesPresenter: HomeNotesPresenter, data: [Note]) {

        arrayNotes = data
        tableView.reloadData()
    }

    func presentFetchNotesWithError(_ HomeNotesPresenter: HomeNotesPresenter, message: String) {
        let alert = UIAlertController(title: "Crash Report", message: message, preferredStyle: .alert)
        let sendReport = UIAlertAction(title: "Send", style: .default) { _ in}
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(sendReport)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}
