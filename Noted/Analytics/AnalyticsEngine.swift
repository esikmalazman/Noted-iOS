//
//  AnalyticsEngine.swift
//  Noted
//
//  Created by Ikmal Azman on 13/03/2022.
//

import Foundation
/// Responsible to send analytics to BE and protocol that implement multiple analytics SDK with single guidelines
protocol AnalyticsEngine: AnyObject {
    func sendAnalyticsEvent(named name: String, metadata: [String: String])
}
