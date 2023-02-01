
import UIKit

class GenresViewController: UITableViewController {
    var presenter = GenresPresenter()
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
        let controller = PodcastComposer.build(genreID: genre.id)
        navigationController?.pushViewController(controller, animated: true)
    }
}
