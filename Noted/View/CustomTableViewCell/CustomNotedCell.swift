//
//  CustomNotedCellTableViewCell.swift
//  Noted
//
//  Created by Ikmal Azman on 19/06/2021.
//

import UIKit

final class CustomNotedCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var subtitleCell: UILabel!
    @IBOutlet weak var cellBg: UIView!

    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellPadding()
        setupCustomCell()
    }

    func configureCell(withData data: Note) {
        titleCell.text = data.title
        subtitleCell.text = data.text
        cellBg.backgroundColor = data.cellColor
    }
}

// MARK: - Private methods
extension CustomNotedCell {
    private func setupCustomCell() {
        selectionStyle = .none

        cellBg.layer.cornerRadius = 10
        cellBg.layer.masksToBounds = true
        titleCell.textColor = Constants.BrandColor.notesColor
        subtitleCell.textColor = Constants.BrandColor.subtitleNotesColor
    }

    private func setupCellPadding() {
        let margins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        contentView.frame = contentView.frame.inset(by: margins)
    }

}
