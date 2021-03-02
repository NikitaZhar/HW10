//
//  TrackListViewController.swift
//  AudioDB
//
//  Created by Nikita Zharinov on 01/03/2021.
//

import UIKit

class TrackListViewController: UITableViewController {
        
    var trackList: Loved = Loved(loved: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 66
 //        activityIndicator.hidesWhenStopped = true
        fetchListTracks()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.loved?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! ConfigureCell
        let track = trackList.loved![indexPath.row]
        cell.configure(with: track)
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Private Methods
    private func successAlert() {
        let alert = UIAlertController(title: "Success",
                                      message: "You can see the results in the Debug aria",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func failedAlert() {
        let alert = UIAlertController(title: "Failed",
                                      message: "You can see error in the Debug aria",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    // MARK: - Get data
    
    private func fetchListTracks() {
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
        
        
        
//        dataTask(with: URLRequest, completionHandler: (Data?, URLResponse?, Error?) throws -> Void)
        
//        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
//            if let error = error {
//                print("Error!!!", error)
//                return
//            }
//
//            if let response = response {
//                print("Response!!!", response)
//            }
//
//            guard let data = data else { return }
//            DispatchQueue.main.async {
//                print("Data")
//
//                //                self.activityIndicator.stopAnimating()
//            }
//
//
//
//            do {
//                let trackList = try JSONDecoder().decode(ListLovedTracks.self, from: data)
//            } catch error {
//                print(error)
//            }
//
//        }.resume()
        
    }
}
