//
//  LovedTrack.swift
//  AudioDB
//
//  Created by Nikita Zharinov on 01/03/2021.
//

struct LovedTrack: Decodable {
    let strTrack: String?
    let strArtist: String?
    let strAlbum: String?
    let strTrackThumb: String?
}

struct Loved: Decodable {
    let loved: [LovedTrack]?
}
