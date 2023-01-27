
import UIKit

class GenresViewController: UITableViewController {
    
    let presenter = GenresPresenter()
    
    var models: [Genre] = []
    var selectedGenreID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        tableView.refreshControl = UIRefreshControl()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        onRefresh()
    }
    
    @objc
    func onRefresh() {
        presenter.getGenres()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PodcastsViewController" {
            let podcastsVC = segue.destination as! PodcastsTableViewController
            podcastsVC.genreID = selectedGenreID
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")!
        let genre = models[indexPath.row]
        cell.textLabel?.text = genre.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = models[indexPath.row]
        selectedGenreID = genre.id
        presenter.onSelect(genre)
        performSegue(withIdentifier: "PodcastsViewController", sender: self)
    }
}

extension GenresViewController: GenresView {
    func display(_ genres: [Genre]) {
        models = genres
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
