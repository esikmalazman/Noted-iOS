//
//  NotesDetailsPresenter.swift
//  Noted
//
//  Created by Ikmal Azman on 19/02/2022.
//

import Foundation

protocol NotesDetailsPresenterDelegate: AnyObject {
    func presentFetchForSelectedNote(_ NotesDetailsPresenter: NotesDetailsPresenter, data: Note)

    func presentActionForEditNotes(_ NotesDetailsPresenter: NotesDetailsPresenter)
}

final class NotesDetailsPresenter {

    weak var delegate: NotesDetailsPresenterDelegate?

    private let cdm = CoreDataManager()

    func fetchNote(withTitle title: String) {
        let predicate = NSPredicate(format: "title = %@ ", title)
      //  let request: NSFetchRequest<Note> = Note.fetchRequest()
       // request.predicate = predicate
        cdm.fetchObjectContext(Note.self, withPredicate: predicate) { result in
            switch result {

            case .success(let data):
                let notes = data as! [Note]
                guard let selectedNoted = notes.first else {
                    print("Could not found first result of notes")
                    return
                }
                self.delegate?.presentFetchForSelectedNote(self, data: selectedNoted)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func saveNotes(_ object: Note) {
        cdm.saveObjectContext(object)
    }

    func didTapEditNotes() {
        delegate?.presentActionForEditNotes(self)
    }

}
