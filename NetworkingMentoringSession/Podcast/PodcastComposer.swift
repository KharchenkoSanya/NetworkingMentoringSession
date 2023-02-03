import UIKit

final class PodcastComposer {
    static func build(genreID: Int) -> UIViewController {
        let presenter = PodcastsPresenter(genreID: genreID)
        let storyboar = UIStoryboard(name: "Main", bundle: nil)
        let podcastsVC = storyboar.instantiateViewController(withIdentifier: "PodcastsViewController") as! PodcastsViewController
        podcastsVC.presenter = presenter
        presenter.view = podcastsVC
        return podcastsVC
    }
}
