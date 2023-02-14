import UIKit

final class EpisodeComposer {
    
    static func build(podcastID: String) -> UIViewController {
        let presenter = EpisodesPresenter(podcastID: podcastID)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let episodesVC = storyboard.instantiateViewController(withIdentifier:
            String(describing: EpisodesViewController.self)) as! EpisodesViewController
        episodesVC.presenter = presenter
        presenter.view = episodesVC
        return episodesVC
    }
}
