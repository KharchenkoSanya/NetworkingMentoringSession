

import UIKit

struct PodcastsResult: Decodable {
    let podcasts: [Podcast]
}

struct Podcast: Decodable {
    let id: String
    let type: String
    let description: String
    let title: String
}

class PodcastsTableViewController: UITableViewController {
    
    var selectedPodcastID: String?
    var podcasts: [Podcast] = []
    var genreID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(getPodcasts), for: .valueChanged)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PodcastTableViewCell")
        getPodcasts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EpisodesViewController" {
            let episodesVC = segue.destination as! EpisodesTableViewController
            episodesVC.podcastID = selectedPodcastID
        }
    }
    
    @objc
    func getPodcasts() {
        guard let genreID = genreID else { return }
        var urlComponents = URLComponents(string: "https://listen-api-test.listennotes.com/api/v2/best_podcasts")!
        urlComponents.queryItems = [URLQueryItem(name: "genre_id", value: String(genreID))]
        var requestPodcasts = URLRequest(url: urlComponents.url!)
        requestPodcasts.httpMethod = "GET"
        let sessionPodcasts = URLSession(configuration: .default)
        let taskPodcasts = sessionPodcasts.dataTask(with: requestPodcasts) { data, response, error in
            guard let data = data else { return }
            do {
                let resultPodcasts = try JSONDecoder().decode(PodcastsResult.self, from: data)
                print("DECODING RESULT \(resultPodcasts)")
                DispatchQueue.main.async {
                    self.podcasts = resultPodcasts.podcasts
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
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastTableViewCell")!
        let podcast = podcasts[indexPath.row]
        cell.textLabel?.text = podcast.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcast = podcasts[indexPath.row]
        selectedPodcastID = podcast.id
        performSegue(withIdentifier: "EpisodesViewController", sender: self)
    }
}
