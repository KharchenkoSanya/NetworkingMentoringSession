import UIKit

final class AppRouter {
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        openGenresScreen()
    }
    
    private func openGenresScreen() {
        let genres = GenreComposer.build(router: self)
        navigationController?.pushViewController(genres, animated: true)
    }
    
    private func openPodcastsScreen(withGenre genre: Genre) {
        let podcasts = PodcastComposer.build(genreID: Int(genre.id), router: self)
        navigationController?.pushViewController(podcasts, animated: true)
    }
    
    private func openEpisodesScreen(withPodcast podcast: Podcast) {
        let episodes = EpisodeComposer.build(podcastID: podcast.id)
        navigationController?.pushViewController(episodes, animated: true)
    }
}

extension AppRouter: GenreRouter {
    
    func route(with genre: Genre) {
        openPodcastsScreen(withGenre: genre)
    }
}

extension AppRouter: PodcastsRouter {
    
    func route(with podcast: Podcast) {
        openEpisodesScreen(withPodcast: podcast)
    }
}
