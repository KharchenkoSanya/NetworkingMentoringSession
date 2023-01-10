import UIKit

struct PodcastsIDResult: Decodable {
    let podcasts: [Podcast]
}

struct PodcastsID: Decodable {
    let type: String
    let description: String
    let title: String
    
}

class EpisodesTableViewController: UITableViewController {
    var podcastID: String?
    var songs: [Podcast] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(getPodcast), for: .valueChanged)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PodcastsIDViewController")
        getPodcast()
        print("PodcastID \(podcastID)")
    }
    
    @objc
    func getPodcast() {
        guard let podcastID = podcastID else { return }
        let url = URL(string: "https://listen-api-test.listennotes.com/api/v2/podcasts")!.appending(component: podcastID)
        var requestPodcasts = URLRequest(url: url)
        requestPodcasts.httpMethod = "GET"
        let sessionPodcasts = URLSession(configuration: .default)
        let taskPodcasts = sessionPodcasts.dataTask(with: requestPodcasts) { data, response, error in
            guard let data = data else { return }
            let dataString = String(data: data, encoding: .utf8)
            print("dataString \(dataString)")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastsIDViewController")!
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.title
        return cell
    }
}
