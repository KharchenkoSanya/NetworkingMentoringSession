// 

import UIKit

struct GenresResult: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let name: String
    let parentID: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case parentID = "parent_id"
    }
}

class ViewController: UITableViewController {
    
    var models: [Genre] = []
    var selectedGenre: Genre?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(getGenres), for: .valueChanged)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        getGenres()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PodcastsViewController" {
            let podcastsVC = segue.destination as! PodcastsTableViewController
            podcastsVC.genre = selectedGenre
        }
    }
    
    @objc
    func getGenres() {
        var request = URLRequest(url: URL(string: "https://listen-api-test.listennotes.com/api/v2/genres")!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(GenresResult.self, from: data)
                print("DECODING RESULT \(result)")
                DispatchQueue.main.async {
                    self.models = result.genres
                    self.tableView.reloadData()
                    self.tableView.refreshControl?.endRefreshing()
                }
            } catch {
                print("DECODING ERROR \(error)")
                DispatchQueue.main.async {
                    self.tableView.refreshControl?.endRefreshing()
                }
            }
        }
        
        tableView.refreshControl?.beginRefreshing()
        task.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        let genre = models[indexPath.row]
        cell.textLabel?.text = genre.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedGenre = models[indexPath.row]
        performSegue(withIdentifier: "PodcastsViewController", sender: self)
    }
}
