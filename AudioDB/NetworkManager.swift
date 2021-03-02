//
//  NetworkManager.swift
//  AudioDB
//
//  Created by Nikita Zharinov on 02/03/2021.
//

import Foundation

extension TrackListViewController {
    // MARK: - Get data
    
    func fetchListTracks() {
        let headers = [
            "x-rapidapi-key": "ba46bd7df0msh469bac161b46366p169216jsn28b13e628019",
            "x-rapidapi-host": "theaudiodb.p.rapidapi.com"
        ]

        guard let requestURL = NSURL(
                string: "https://theaudiodb.p.rapidapi.com/mostloved.php?format=track"
        ) else { return }
        
        let request = NSMutableURLRequest(
            url: requestURL as URL,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10.0
        )
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            if let error = error {
                print("Error!!!", error.localizedDescription)
                DispatchQueue.main.async {
                    self.failedAlert()
                }
                return
            }
            guard let data = data else { return }
            DispatchQueue.main.async {
                print("Data \(data)")
                //                self.activityIndicator.stopAnimating()
            }
            do {
                self.trackList = try JSONDecoder().decode(Loved.self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error as NSError  {
                print("Error of decoding \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.failedAlert()
                }
            }
        }.resume()
    }

}
