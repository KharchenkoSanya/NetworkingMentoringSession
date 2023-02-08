import Foundation

protocol EpisodeView: AnyObject {
    func display(_ episodes: [Episode])
    func display(isLoading: Bool)
}

final class EpisodesPresenter {
    
    weak var view: EpisodeView?
    var podcastID: String
    
    init(podcastID: String) {
        self.podcastID = podcastID
    }
    
    @objc
    func getEpisode() {
        view?.display(isLoading: true)
        let link = "https://listen-api-test.listennotes.com/api/v2/podcasts"
        let url = URL(string: link)!.appending(component: podcastID)
        var requestEpisodes = URLRequest(url: url)
        requestEpisodes.httpMethod = "GET"
        let sessionEpisodes = URLSession(configuration: .default)
        let taskEpisodes = sessionEpisodes.dataTask(with: requestEpisodes) { data, _, _ in
            guard let data = data else { return }
            do {
                let resultEpisodes = try JSONDecoder().decode(EpisodesResult.self, from: data)
                DispatchQueue.main.async {
                    self.view?.display(resultEpisodes.episodes)
                    self.view?.display(isLoading: false)
                }
            } catch {
                DispatchQueue.main.async {
                    self.view?.display(isLoading: false)
                }
            }
        }
        taskEpisodes.resume()
    }
}
