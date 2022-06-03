//
//  APOD.swift
//  SwiftUI-NASA-API
//
//  Created by Buena, Franco on 23/5/2022.
//

import Foundation

struct APOD: Identifiable, Codable {
    var id = UUID()
    var date: String?
    var explanation: String?
    var hdurl: String?
    var mediaType: String?
    var serviceVersion: String?
    var title: String?
    var url: String?
    var copyright: String?
    var thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
        case copyright
        case thumbnail = "thumbnail_url"
    }
    
    var imageURL: String? {
        return mediaType == "video" ? thumbnail : url
    }
}
