

import UIKit

struct PodcastsResult: Decodable {
    let podcasts: [Podcasts]
}

struct Podcasts: Decodable {
    let type: String
    let description: String
    let title: String
    
    private enum PodcastsCodingKeys: String, CodingKey {
        case type
        case description
        case title
    }
}

class PodcastsTableViewController: UITableViewController {
    
    var songs: [Podcasts] = []
    var genre: Genre?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(getPodcasts), for: .valueChanged)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PodcastTableViewCell")
        getPodcasts()
    }
    
    @objc
    func getPodcasts() {
        guard let genre = genre else { return }
        var urlComponents = URLComponents(string: "https://listen-api-test.listennotes.com/api/v2/best_podcasts")!
        urlComponents.queryItems = [URLQueryItem(name: "genre_id", value: String(genre.id))]
        var requestPodcasts = URLRequest(url: urlComponents.url!)
        requestPodcasts.httpMethod = "GET"
        let sessionPodcasts = URLSession(configuration: .default)
        let taskPodcasts = sessionPodcasts.dataTask(with: requestPodcasts) { data, response, error in
            guard let data = data else { return }
            do {
                let resultPodcasts = try JSONDecoder().decode(PodcastsResult.self, from: data)
                print("DECODING RESULT \(resultPodcasts)")
                DispatchQueue.main.async {
                    self.songs = resultPodcasts.podcasts
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
        taskPodcasts.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastTableViewCell")!
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.title
        return cell
    }
}
