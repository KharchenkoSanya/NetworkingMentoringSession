import UIKit

final class GenreComposer {
    
    static func build() -> UIViewController {
        let presenter = GenresPresenter()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let genresVC = storyboard.instantiateViewController(withIdentifier:
            String(describing: GenresViewController.self)) as! GenresViewController
        let genresVc2 = GenresViewController(nibName: "PodcastsXib", bundle: nil)
        genresVC.presenter = presenter
        presenter.view = genresVC
        return genresVC
    }
}
