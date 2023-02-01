
import UIKit

class EpisodeComposer {
    static func build(podcastID: String) -> UIViewController {
        let presenter = EpisodesPresenter(podcastID: podcastID)
        let storyboar = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboar.instantiateViewController(withIdentifier: "EpisodesTableViewController") as!
        EpisodesTableViewController
        vc.presenter = presenter
        presenter.view = vc
        return vc
    }
}