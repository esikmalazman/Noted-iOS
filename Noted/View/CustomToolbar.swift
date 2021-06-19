//
//  CustomToolbar.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit
protocol CustomToolBarDelegate {
    func didSetBackgroundColor(view : Any, with color : UIColor)
}

class CustomToolbar: UIToolbar {

    @IBOutlet weak var purpleButton: UIBarButtonItem!
    @IBOutlet weak var blueButton: UIBarButtonItem!
    @IBOutlet weak var greenButton: UIBarButtonItem!
    @IBOutlet weak var yellowButton: UIBarButtonItem!
    @IBOutlet weak var redButton: UIBarButtonItem!
   
    var customDelegate : CustomToolBarDelegate?
    
    override func awakeFromNib() {
        setupButton()
    }

    @IBAction func colorToolBarPressed(_ sender: UIBarButtonItem) {
        
        guard let selectColor = sender.tintColor else {return}
        print(sender.tintColor!)
        customDelegate?.didSetBackgroundColor(view: self, with: selectColor)
    }
    
    func setupButton(){
        
        purpleButton.tintColor = Constants.ToolBarColor.purple
        blueButton.tintColor = Constants.ToolBarColor.blue
        greenButton.tintColor = Constants.ToolBarColor.green
        yellowButton.tintColor = Constants.ToolBarColor.yellow
        redButton.tintColor = Constants.ToolBarColor.red
    }
    
}
