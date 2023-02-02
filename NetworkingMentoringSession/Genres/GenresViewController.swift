
import UIKit

// ISSUE: - Pull to refresh doesn't work on this screen

class GenresViewController: UITableViewController {
    var presenter = GenresPresenter()
    var models: [Genre] = []
    
    // ISSUE: - This variable is not used
    var selectedGenreID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        tableView.refreshControl = UIRefreshControl()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "GenreTableViewCell")
        onRefresh()
    }
    
    @objc
    func onRefresh() {
        presenter.getGenres()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreTableViewCell")!
        let genre = models[indexPath.row]
        cell.textLabel?.text = genre.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let genre = models[indexPath.row]
        selectedGenreID = genre.id
        
        // ISSUE: - Unused presenter message
        presenter.onSelect(genre)
        let controller = PodcastComposer.build(genreID: genre.id)
        navigationController?.pushViewController(controller, animated: true)
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
