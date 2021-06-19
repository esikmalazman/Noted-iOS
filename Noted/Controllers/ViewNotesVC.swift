//
//  ViewNotesVC.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit

class ViewNotesVC: UIViewController {

    var notesTitle : String?
    var notesText : String?
    var notesBgColor : UIColor?
    
    @IBOutlet weak var viewTitle: UITextField!
    @IBOutlet weak var viewText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewTitle.text = notesTitle
        viewText.text = notesText
        view.backgroundColor = notesBgColor
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
