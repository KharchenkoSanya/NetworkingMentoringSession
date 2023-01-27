
import UIKit

class PodcastsTableViewController: UITableViewController {
    
    let presenter = PodcastsPresenter()
    
    var selectedPodcastID: String?
    var podcasts: [Podcast] = []
    var genreID: Int?
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EpisodesViewController" {
            let episodesVC = segue.destination as! EpisodesTableViewController
            episodesVC.podcastID = selectedPodcastID
        }
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
        performSegue(withIdentifier: "EpisodesViewController", sender: self)
    }
}

extension PodcastsTableViewController: PodcastsView {
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
