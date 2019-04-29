//
//  MediaResult.swift
//  iTunesMedia
//
//  Created by Kusum Miraj on 4/29/19.
//  Copyright © 2019 Kusum Miraj. All rights reserved.
//

import Foundation

struct Feed: Codable {
    var feed: MediaResult
    
}

struct MediaResult: Codable {
    var results: [Media]
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
}
