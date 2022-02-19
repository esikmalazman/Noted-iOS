//
//  CreateNotesPresenter.swift
//  Noted
//
//  Created by Ikmal Azman on 19/02/2022.
//

import Foundation

protocol CreateNotesPresenterDelegate: AnyObject {
    func presentActionForSaveNotes(_ CreateNotesPresenter: CreateNotesPresenter)
}

final class CreateNotesPresenter {

    weak var delegate: CreateNotesPresenterDelegate?

    let cdm = CoreDataManager()

    func saveNotes(_ object: Note) {
        cdm.saveObjectContext(object)
    }

    func didTapSaveNotes() {
        delegate?.presentActionForSaveNotes(self)
    }

}
