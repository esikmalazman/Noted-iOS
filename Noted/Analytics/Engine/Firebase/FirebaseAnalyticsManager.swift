//
//  FirebaseAnalyticsManager.swift
//  Noted
//
//  Created by Ikmal Azman on 13/03/2022.
//

import Foundation
/// Provide an API to log given event
final class FirebaseAnalyticsManager {
    private let engine: AnalyticsEngine

    init(engine: AnalyticsEngine) {
        self.engine = engine
    }

    func log(_ event: AnalyticsEvent) {
        engine.sendAnalyticsEvent(named: event.name, metadata: event.metadata)
    }
}
