//
//  MediaCell.swift
//  iTunesMedia
//
//  Created by Kusum Miraj on 4/29/19.
//  Copyright © 2019 Kusum Miraj. All rights reserved.
//

import UIKit

class MediaCell: UITableViewCell {
    
    var media: Media? {
        didSet {
            mediaNameLabel.text = media?.name
            mediaTypeLabel.text = media?.mediaType
            if let urlString = media?.imageURLString, let url = URL(string: urlString) {
                let data = try? Data(contentsOf: url)
                imageview.image = UIImage(data: data!)
            }
        }
    }
    
    private let mediaNameLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30))
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let mediaTypeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageview: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageview)
        contentView.addSubview(mediaNameLabel)
        contentView.addSubview(mediaTypeLabel)
        
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    func setConstraints() {
        let margins = contentView.layoutMarginsGuide
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageview.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 5).isActive = true
        imageview.topAnchor.constraint(equalTo: margins.topAnchor, constant: 5).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 40).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        mediaNameLabel.leadingAnchor.constraint(equalTo: imageview.trailingAnchor, constant: 20).isActive = true
        mediaNameLabel.topAnchor.constraint(equalTo: margins.topAnchor, constant: 8).isActive = true

        mediaTypeLabel.leadingAnchor.constraint(equalTo: imageview.trailingAnchor, constant: 20).isActive = true
        mediaTypeLabel.topAnchor.constraint(equalTo: mediaNameLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        media = nil
    }

}
