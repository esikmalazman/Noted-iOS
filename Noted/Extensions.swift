//
//  Extensions.swift
//  Noted
//
//  Created by Ikmal Azman on 11/07/2021.
//

import UIKit

extension UITableView {

    /// Set empty state for empty tableview
    func setEmptyMessage(_ message: String, _ textColor: UIColor = .black) {

        let messageLabel = UILabel()
        messageLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "Montserrat-Medium", size: 20)
        messageLabel.textColor = textColor
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {

        self.backgroundView = nil

    }
}
