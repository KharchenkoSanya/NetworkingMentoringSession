import UIKit

final class EpisodeComposer {
    
    static func build(podcastID: String, onEpisodeSelect: ((Episode) -> Void)?) -> UIViewController {
        let presenter = EpisodesPresenter(podcastID: podcastID)
        let episodesVC = EpisodesViewController()
        episodesVC.onEpisodeSelect = onEpisodeSelect
        episodesVC.presenter = presenter
        presenter.view = episodesVC
        return episodesVC
    }
}
