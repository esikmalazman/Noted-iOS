//
//  FirebaseAnalyticsEngine.swift
//  Noted
//
//  Created by Ikmal Azman on 13/03/2022.
//

import Foundation
import Firebase

final class FirebaseAnalyticsEngine: AnalyticsEngine {

    private let database = Analytics.self

    func sendAnalyticsEvent(named name: String, metadata: [String: String]) {

        for (key, value) in metadata {
            database.logEvent(name, parameters: [key: value])
        }
    }
}
