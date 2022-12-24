//
//  Settings.swift
//  WordBraker
//
//  Created by 하진호 on 2022/12/23.
//

import Foundation

enum Settings: String, CaseIterable, Identifiable {
    case UK, US, AU
    
    var id: Self {
        self
    }
    
    var pronunciate: String {
        switch self {
        case .UK:
            return "en-GB"
        case .US:
            return "en-US"
        case .AU:
            return "en-AU"
        }
    }
}
