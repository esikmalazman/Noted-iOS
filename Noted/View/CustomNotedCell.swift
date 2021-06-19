//
//  CustomNotedCellTableViewCell.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit

class CustomNotedCell: UITableViewCell {

    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var subtitleCell: UILabel!
    @IBOutlet weak var cellBg: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCustomCell()

    }
    override func layoutSubviews() {
        super.layoutSubviews()
        customCellSpace()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCustomCell() {

        cellBg.layer.cornerRadius = 10
        cellBg.layer.masksToBounds = true

    }
    func customCellSpace() {
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }

}
