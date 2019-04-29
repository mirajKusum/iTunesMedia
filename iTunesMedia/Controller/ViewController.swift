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
        return UITableView()
    }()
    
    var results = [Media]()
    let cellIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        tableview.frame = view.frame
        view.addSubview(tableview)
        
        tableview.dataSource = self
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableview.tableFooterView = UIView()
        fetchSongMedia()
    }
    
    func fetchSongMedia() {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/itunes-music/hot-tracks/all/10/explicit.json"
        NetworkService.shared.fetchResults(with: urlString) { [weak self] response in
            print(response.feed.results)
            self?.results = response.feed.results
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let result = results[indexPath.row]
        cell.textLabel?.text = result.name
        if let urlString = result.imageURLString, let url = URL(string: urlString) {
            let data = try? Data(contentsOf: url)
            cell.imageView?.image = UIImage(data: data!)
        }
        
        return cell
    }
}

