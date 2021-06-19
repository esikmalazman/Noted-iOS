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
        setupView()

    }
    

    func setupView(){
        viewTitle.text = notesTitle
        viewText.text = notesText
        view.backgroundColor = notesBgColor
        viewTitle.backgroundColor = notesBgColor
        viewText.backgroundColor = notesBgColor
    }

}
