//
//  NetworkService.swift
//  iTunesMedia
//
//  Created by Kusum Miraj on 4/29/19.
//  Copyright © 2019 Kusum Miraj. All rights reserved.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    func fetchResults(with urlString: String, completion: @escaping (_ response: Feed) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching data: \(String(describing: error?.localizedDescription))")
                return
            }
            
            do {
                let jsonResponse = try JSONDecoder().decode(Feed.self, from: data)
                print(jsonResponse)
                completion(jsonResponse)
            } catch let parsingError {
                print("Error: \(parsingError.localizedDescription)")
            }
        }
        task.resume()
        
    }
}
