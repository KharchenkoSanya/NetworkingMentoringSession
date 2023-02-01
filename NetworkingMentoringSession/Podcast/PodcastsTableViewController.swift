
import UIKit

class PodcastsTableViewController: UITableViewController {
    var presenter: PodcastsPresenter!
    var selectedPodcastID: String?
    var podcasts: [Podcast] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        tableView.refreshControl = UIRefreshControl()
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
        selectedPodcastID = podcast.id
        presenter.onSelect(podcast)
        let controller = EpisodeComposer.build(podcastID: podcast.id)
        navigationController?.pushViewController(controller, animated: true)
    }
}
