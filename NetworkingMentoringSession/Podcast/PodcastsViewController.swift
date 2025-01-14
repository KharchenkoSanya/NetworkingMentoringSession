import UIKit

final class PodcastsViewController: UITableViewController {
    var presenter: PodcastsPresenter!
    var podcasts: [Podcast] = []
    
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
        presenter.onSelectedPodcast(podcast)
        
//        let controller = EpisodeComposer.build(podcastID: podcast.id, onEpisodeSelect: selectEpisode)
//        navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func selectEpisode (episode: Episode) {
        self.showAlert(title: "selected \(episode.title)")
        }
    
    func showAlert(title: String) {
        self.navigationController?.presentedViewController?.dismiss(animated: true)
        let alert = UIAlertController(title: "Your episode", message: title, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
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
