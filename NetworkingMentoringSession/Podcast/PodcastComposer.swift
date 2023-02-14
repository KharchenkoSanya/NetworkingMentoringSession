import UIKit

final class PodcastComposer {
    
    static func build(genreID: Int) -> UIViewController {
        let presenter = PodcastsPresenter(genreID: genreID)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let podcastsVC = storyboard.instantiateViewController(withIdentifier:
            String(describing: PodcastsViewController.self)) as! PodcastsViewController
        podcastsVC.presenter = presenter
        presenter.view = podcastsVC
        return podcastsVC
    }
}
