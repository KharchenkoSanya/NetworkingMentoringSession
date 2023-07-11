import UIKit

final class PodcastComposer {
    
    static func build(genreID: Int, router: PodcastsRouter) -> UIViewController {
        let presenter = PodcastsPresenter(genreID: genreID)
        let podcastsVC = PodcastsViewController()
        podcastsVC.presenter = presenter
        presenter.router = router
        return podcastsVC
    }
}
