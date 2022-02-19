//
//  CoreDataManager.swift
//  Noted
//
//  Created by Ikmal Azman on 19/02/2022.
//

import CoreData

final class CoreDataManager {

    private let context = Constants.accessObjectContext

    func saveObjectContext(_ object: NSManagedObject, completion : @escaping (() -> Void) = {}) {
        do {
            try context.save()
            completion()
        } catch {
            print("Error saving object : \(object) into Context with error : \(error.localizedDescription)")
            completion()
        }
    }

    func removeObjectContext(_ object: NSManagedObject) {
        context.delete(object)
        self.saveObjectContext(object)
    }

    func fetchObjectContext<T: NSManagedObject>(_ object: T.Type,
                                               withPredicate predicate: NSPredicate? = nil,
                                               completion : @escaping (Result<[NSFetchRequestResult], Error>) -> Void) {

        let request = T.fetchRequest()
        request.predicate = predicate

        do {
            let fetchedObject = try context.fetch(request)
            completion(.success(fetchedObject))
        } catch {
            print("Error fetching requested data from Context : \(request), with error : \(error.localizedDescription)")
            completion(.failure(error.localizedDescription as! Error))
        }

    }

    func accessContext() -> NSManagedObjectContext {
        return context
    }
}
