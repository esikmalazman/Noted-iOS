//
//  ViewController.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit
import CoreData

class BaseVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrayNotes = [Note]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //Receive notification if new items added
        NotificationCenter.default.addObserver(self, selector: #selector(loadNotes), name: NSNotification.Name(rawValue: "loadTableView"), object: nil)
        loadNotes()
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
        //Navigate to NotesVC
        let notesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesVC") as! NotesVC
        self.navigationController?.pushViewController(notesVC, animated: true)
    }
}


//MARK:- Table Delegate
extension BaseVC : UITableViewDelegate{
    
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
    
}


//MARK:- Table Datasource
extension BaseVC : UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayNotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let listOfNotes = arrayNotes[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifierNote, for: indexPath)
        cell.textLabel?.text = listOfNotes.text
        cell.detailTextLabel?.text = listOfNotes.title
        cell.backgroundColor = listOfNotes.cellColor
        return cell
    }
}

//MARK:- Data Manipulation Methods
extension BaseVC {
    
    @objc func loadNotes(){
        
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        do{
            arrayNotes = try context.fetch(request)
        }catch{
            print("Error load context \(error)")
        }
        tableView.reloadData()
    }
}
