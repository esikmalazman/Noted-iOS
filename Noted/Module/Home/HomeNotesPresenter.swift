//
//  HomeNotesPresenter.swift
//  Noted
//
//  Created by Ikmal Azman on 19/02/2022.
//

import Foundation

protocol HomeNotesPresenterDelegate: AnyObject {
    func presentFetchNotesWhenSuccess(_ HomeNotesPresenter: HomeNotesPresenter, data: [Note] )
    func presentFetchNotesWithError(_ HomeNotesPresenter: HomeNotesPresenter, message: String)
}

final class HomeNotesPresenter {

    weak var delegate: HomeNotesPresenterDelegate?

    private let cdm = CoreDataManager()

    func deleteNotes(_ object: Note) {
        cdm.removeObjectContext(object)
    }

    func reloadNotes() {
        cdm.fetchObjectContext(Note.self, withPredicate: nil) { [weak self] result in
            switch result {

            case .success(let data):
                print("Succes Fetch Data from context : \(data)")
                let notes = data as! [Note]
                DispatchQueue.main.async {
                    self?.delegate?.presentFetchNotesWhenSuccess(self!, data: notes)
                }

            case .failure(let error):
                let message = "There is an error when fetch data from database : \(error.localizedDescription)"
                self?.delegate?.presentFetchNotesWithError(self!, message: message)
            }
        }
    }
}
