
import UIKit

class EpisodesTableViewController: UITableViewController {
    var presenter: EpisodesPresenter!
    var episodeID: String?
    var episodes: [Episode] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        tableView.refreshControl = UIRefreshControl()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PodcastsIDViewController")
        onRefresh()
    }
    
    @objc
    func onRefresh() {
        presenter.getEpisode()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PodcastsIDViewController")!
        let song = episodes[indexPath.row]
        cell.textLabel?.text = song.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = episodes[indexPath.row]
        episodeID = episode.id
        presenter.onSelect(episode)
    }
}
