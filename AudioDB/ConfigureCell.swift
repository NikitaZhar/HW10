//
//  ConfigureCell.swift
//  AudioDB
//
//  Created by Nikita Zharinov on 02/03/2021.
//

import UIKit

class ConfigureCell: UITableViewCell {

    @IBOutlet var trackTambImage: UIImageView!
    @IBOutlet var trackLabel: UILabel!
    @IBOutlet var artistLabel: UILabel!
    @IBOutlet var albomLabel: UILabel!
    
    func configure(with track: LovedTrack) {
        trackLabel.text = track.strTrack
        artistLabel.text = track.strArtist
//        albomLabel.text = track.strAlbum
        
        DispatchQueue.global().async {
            guard let stringURL = track.strTrackThumb else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.trackTambImage.image = UIImage(data: imageData)
            }
        }
    }
}
