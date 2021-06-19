//
//  NotesVC.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit
import CoreData

class NotesVC: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var notesTitle: UITextField!
    @IBOutlet weak var notesText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        
    
        
        let newNotes = Note(context: context)
        newNotes.title = notesTitle.text
        newNotes.text = notesText.text
        newNotes.cellColor = UIColor.green
        
        print("New Notes Saved")
        saveNotes()
        //Notify baseVC that new notes added
        NotificationCenter.default.post(name: NSNotification.Name("loadTableView"), object: nil)
        self.navigationController?.popToRootViewController(animated: true)
       
        
    }
}

//MARK:- Data Manipulation
extension NotesVC{
    func saveNotes(){
        
        do {
            try context.save()
            
        }catch{
            print("Error saving context \(error)")
        }
    }
}
