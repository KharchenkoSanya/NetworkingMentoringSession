import UIKit

final class PodcastComposer {
    
    static func build(genreID: Int) -> UIViewController {
        let presenter = PodcastsPresenter(genreID: genreID)
        let podcastsVC = PodcastsViewController()
        podcastsVC.presenter = presenter
        presenter.view = podcastsVC
        return podcastsVC
    }
}
