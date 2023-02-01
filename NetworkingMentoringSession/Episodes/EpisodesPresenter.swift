
import Foundation

protocol EpisodeView: AnyObject {
    func display(_ episodes: [Episode])
    func display(isLoading: Bool)
}

class EpisodesPresenter {
    
    weak var view: EpisodeView?
    var podcastID: String
    
    init(podcastID: String) {
        self.podcastID = podcastID
    }
    
    @objc
    func getEpisode() {
        view?.display(isLoading: true)
        let url = URL(string: "https://listen-api-test.listennotes.com/api/v2/podcasts")!.appending(component: podcastID)
        var requestEpisodes = URLRequest(url: url)
        requestEpisodes.httpMethod = "GET"
        let sessionEpisodes = URLSession(configuration: .default)
        let taskEpisodes = sessionEpisodes.dataTask(with: requestEpisodes) { data, response, error in
            guard let data = data else { return }
            do {
                let resultEpisodes = try JSONDecoder().decode(EpisodesResult.self, from: data)
                print("DECODING RESULT \(resultEpisodes)")
                DispatchQueue.main.async {
                    self.view?.display(resultEpisodes.episodes)
                    self.view?.display(isLoading: false)
                }
            } catch {
                print("DECODING ERROR \(error)")
                DispatchQueue.main.async {
                    self.view?.display(isLoading: false)
                }
            }
        }
        taskEpisodes.resume()
    }
    
    func onSelect(_ episode: Episode) {
        print("SELECTED \(episode)")
    }
}
