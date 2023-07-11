import UIKit

final class EpisodeComposer {
    
    static func build(podcastID: String) -> UIViewController {
        let presenter = EpisodesPresenter(podcastID: podcastID)
        let episodesVC = EpisodesViewController()
        episodesVC.presenter = presenter
        presenter.view = episodesVC
        return episodesVC
    }
}
