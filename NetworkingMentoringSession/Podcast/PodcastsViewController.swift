import UIKit

final class PodcastsViewController: UITableViewController {
    var presenter: PodcastsPresenter!
    var podcasts: [Podcast] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Podcast"
        presenter.view = self
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PodcastTableViewCell")
        onRefresh()
    }
    
    @objc
    func onRefresh() {
        presenter.getPodcasts()
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
        let controller = EpisodeComposer.build(podcastID: podcast.id)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension PodcastsViewController: PodcastsView {
    
    func display(_ podcast: [Podcast]) {
        podcasts = podcast
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
