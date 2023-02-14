import UIKit

final class GenreComposer {
    
    static func build() -> UIViewController {
        let presenter = GenresPresenter()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let id = "GenresViewController"
        let genresVC = storyboard.instantiateViewController(withIdentifier: id) as! GenresViewController
        genresVC.presenter = presenter
        presenter.view = genresVC
        return genresVC
    }
}
