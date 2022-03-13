//
//  AnalyticsEvent.swift
//  Noted
//
//  Created by Ikmal Azman on 13/03/2022.
//

import Foundation

/// List of analytics event that suppor in-app
enum AnalyticsEvent {
    case listOfNoteScreenViewed
    case noteDetailsScreenViewed
    case createNoteScreenViewed

    case colorSelected(selected: Bool)
    case textAdded

    case noteCreated
    case noteSaved
    case noteDeleted(index: Int)
    case noteRead(index: Int)

    case appScreenOpened
    case appScreenDissapeared
}

/// Serialize events value for engine consumption
extension AnalyticsEvent {
    var name: String {
        switch self {
        case .listOfNoteScreenViewed:
            return "list_of_note_screen_viewed"
        case .noteDetailsScreenViewed:
            return "note_details_screen_viewed"
        case .createNoteScreenViewed:
            return  "create_note_screen_viewed"
        case .colorSelected:
            return  "color_selected"
        case .textAdded:
            return "text_added"
        case .noteCreated:
            return "note_created"
        case .noteSaved:
            return "note_saved"
        case .noteDeleted:
            return "note_deleted"
        case .noteRead:
            return "note_read"
        case .appScreenOpened:
            return "app_screen_open"
        case .appScreenDissapeared :
            return "app_screen_dissapeared"
        }
    }
}

/// Convert enum value to dictionary
extension AnalyticsEvent {
    var metadata: [String: String] {
        switch self {
        case .listOfNoteScreenViewed:
            return ["list_of_note_screen_viewed": "1"]
        case .noteDetailsScreenViewed:
            return ["note_details_screen_viewed": "1"]
        case .createNoteScreenViewed:
            return ["create_note_screen_viewed": "1"]

        case .colorSelected(let selected):
            return ["color_selected": "\(selected)"]
        case .noteDeleted(let index):
            return ["note_deleted": "\(index)"]
        case .noteRead(let index):
            return ["note_read": "\(index)"]
        case .textAdded:
            return ["text_added": "1"]
        case .noteCreated:
            return ["note_created": "1"]
        case .noteSaved:
            return ["note_saved": "1"]
        case .appScreenOpened:
            return ["app_screen_open": "1"]
        case .appScreenDissapeared:
            return ["app_screen_dissapearedd": "1"]

        }
    }
}
