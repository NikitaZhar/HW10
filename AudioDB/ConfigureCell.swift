//
//  ConfigureCell.swift
//  AudioDB
//
//  Created by Nikita Zharinov on 02/03/2021.
//

import UIKit

class ConfigureCell: UITableViewCell {

    func configure (with track: LovedTrack) {
        var content = cell.defaultContentConfiguration()
        content.text = track.strArtist
        content.secondaryText = track.strTrack
    }
    
    var content = cell.defaultContentConfiguration()
    content.text = track.strArtist
    content.secondaryText = track.strTrack
    
    let imageData = try? Data(contentsOf: URL(string: track.strTrackThumb)!)
    DispatchQueue.main.async {
        self.content.image = UIImage(data: imageData!)
    }
    
    
}
