
import UIKit

class PodcastComposer {
    static func build(genreID: Int) -> UIViewController {
        let presenter = PodcastsPresenter(genreID: genreID)
        let storyboar = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboar.instantiateViewController(withIdentifier: "PodcastsTableViewController") as!
        PodcastsTableViewController
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
}
