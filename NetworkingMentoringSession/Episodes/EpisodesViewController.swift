import UIKit

final class EpisodesViewController: UITableViewController {
    var presenter: EpisodesPresenter!
    var episodes: [Episode] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EpisodeTableViewCell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodeTableViewCell")!
        let song = episodes[indexPath.row]
        cell.textLabel?.text = song.title
        return cell
    }
}

extension EpisodesViewController: EpisodeView {
    func display(_ episode: [Episode]) {
        episodes = episode
        tableView.reloadData()
    }
    
    func display(isLoading: Bool) {
        if isLoading {
            tableView.refreshControl?.beginRefreshing()
        } else {
            tableView.refreshControl?.endRefreshing()
        }
    }
}
