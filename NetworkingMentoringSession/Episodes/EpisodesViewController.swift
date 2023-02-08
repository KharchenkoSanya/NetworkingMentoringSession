import UIKit

final class EpisodesViewController: UITableViewController {
    var presenter: EpisodesPresenter!
    var episodes: [Episode] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Episode"
        let customCellNib = UINib(nibName: "EpisodesCell", bundle: nil)
        tableView.register(customCellNib, forCellReuseIdentifier: "EpisodesCell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "EpisodesCell") as! EpisodesCell
        let episode = episodes[indexPath.row]
        cell.setup(with: episode)
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
