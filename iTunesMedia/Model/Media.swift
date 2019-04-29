//
//  Media.swift
//  iTunesMedia
//
//  Created by Kusum Miraj on 4/29/19.
//  Copyright © 2019 Kusum Miraj. All rights reserved.
//

import Foundation

struct Media: Codable {
    var name: String
    var mediaType: String
    var imageURLString: String?
    
    private enum CodingKeys: String, CodingKey {
        case name
        case mediaType = "kind"
        case imageURLString = "artworkUrl100"
    }
}
