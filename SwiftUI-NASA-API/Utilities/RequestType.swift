//
//  RequestType.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 20/6/2022.
//

import Foundation

public enum RequestType: CaseIterable, Hashable {
    public static var allCases: [RequestType] {
        return [.lastWeek, .randomImage, .pickADate("")]
    }
    
    case lastWeek
    case randomImage
    case pickADate(String)
    
    var description: String {
        switch self {
        case .lastWeek:
            return "Last seven days"
        case .randomImage:
            return "Random Image"
        case .pickADate:
            return "Pick a date"
        }
    }
}
