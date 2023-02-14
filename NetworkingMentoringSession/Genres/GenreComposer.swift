import UIKit

final class GenreComposer {
    
    static func build() -> UIViewController {
        let presenter = GenresPresenter()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let genresVC = storyboard.instantiateViewController(withIdentifier:
            String(describing: GenresViewController.self)) as! GenresViewController
        genresVC.presenter = presenter
        presenter.view = genresVC
        return genresVC
    }
}
