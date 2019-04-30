//
//  ViewController.swift
//  iTunesMedia
//
//  Created by Kusum Miraj on 4/29/19.
//  Copyright © 2019 Kusum Miraj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableview: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    var results = [Media]()
    let cellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        title = "My Media"
        tableview.frame = view.frame
        view.addSubview(tableview)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        let margins = view.layoutMarginsGuide
        tableview.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        tableview.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        tableview.dataSource = self
        tableview.register(MediaCell.self, forCellReuseIdentifier: cellIdentifier)
        tableview.tableFooterView = UIView()
        tableview.rowHeight = 80
        fetchSongMedia()
        fetchAppMedia()
    }
    
    func fetchSongMedia() {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/itunes-music/hot-tracks/all/10/explicit.json"
        NetworkService.shared.fetchResults(with: urlString) { [weak self] response in
            print(response.feed.results)
            self?.results.append(contentsOf: response.feed.results)
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
            
        }
    }
    
    func fetchAppMedia() {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/10/explicit.json"
        NetworkService.shared.fetchResults(with: urlString) { [weak self] response in
            print(response.feed.results)
            self?.results.append(contentsOf: response.feed.results)
            DispatchQueue.main.async {
                self?.tableview.reloadData()
            }
            
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MediaCell else {
            fatalError("Media cell not found")
        }
        let result = results[indexPath.row]
        cell.media = result
        return cell
    }
}

