import UIKit

final class EpisodeComposer {
    static func build(podcastID: String) -> UIViewController {
        let presenter = EpisodesPresenter(podcastID: podcastID)
        let storyboar = UIStoryboard(name: "Main", bundle: nil)
        let id = "EpisodesViewController"
        let episodesVC = storyboar.instantiateViewController(withIdentifier: id) as! EpisodesViewController
        episodesVC.presenter = presenter
        presenter.view = episodesVC
        return episodesVC
    }
}
