//
//  CustomToolbar.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit

// class, only allow class to adopt the protocol
protocol CustomToolBarDelegate: AnyObject {
    func didSetBackgroundColor(view: Any, with color: UIColor)
}

final class CustomToolbar: UIToolbar {

    // MARK: - Outlets
    @IBOutlet weak var purpleButton: UIBarButtonItem!
    @IBOutlet weak var blueButton: UIBarButtonItem!
    @IBOutlet weak var greenButton: UIBarButtonItem!
    @IBOutlet weak var yellowButton: UIBarButtonItem!
    @IBOutlet weak var redButton: UIBarButtonItem!

    // MARK: - Variables
    weak var customDelegate: CustomToolBarDelegate?

    // MARK: - LifeCycle
    override func awakeFromNib() {
        setupButton()
    }

    // MARK: - Actions
    @IBAction func colorToolBarPressed(_ sender: UIBarButtonItem) {

        guard let selectColor = sender.tintColor else {return}
        print(sender.tintColor!)
        customDelegate?.didSetBackgroundColor(view: self, with: selectColor)
    }
}

// MARK: - Private methods
extension CustomToolbar {
    private func setupButton() {
        purpleButton.tintColor = Constants.ToolBarColor.purple
        blueButton.tintColor = Constants.ToolBarColor.blue
        greenButton.tintColor = Constants.ToolBarColor.green
        yellowButton.tintColor = Constants.ToolBarColor.yellow
        redButton.tintColor = Constants.ToolBarColor.red

        purpleButton.image = UIImage(systemName: "circle.fill")
        blueButton.image = UIImage(systemName: "circle.fill")
        greenButton.image = UIImage(systemName: "circle.fill")
        yellowButton.image = UIImage(systemName: "circle.fill")
        redButton.image = UIImage(systemName: "circle.fill")
    }
}
