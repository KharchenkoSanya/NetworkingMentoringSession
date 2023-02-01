
import Foundation

protocol PodcastsView: AnyObject {
    func display(_ podcasts: [Podcast])
    func display(isLoading: Bool)
}

class PodcastsPresenter {
    weak var view: PodcastsView?
    var genreID: Int
    
    init(genreID: Int) {
        self.genreID = genreID
    }
    
    @objc
    func getPodcasts() {
        view?.display(isLoading: true)
        var urlComponents = URLComponents(string: "https://listen-api-test.listennotes.com/api/v2/best_podcasts")!
        urlComponents.queryItems = [URLQueryItem(name: "genre_id", value: String(genreID))]
        var requestPodcasts = URLRequest(url: urlComponents.url!)
        requestPodcasts.httpMethod = "GET"
        let sessionPodcasts = URLSession(configuration: .default)
        let taskPodcasts = sessionPodcasts.dataTask(with: requestPodcasts) { data, response, error in
            guard let data = data else { return }
            do {
                let resultPodcasts = try JSONDecoder().decode(PodcastsResult.self, from: data)
                print("DECODING RESULT \(resultPodcasts)")
                DispatchQueue.main.async {
                    self.view?.display(resultPodcasts.podcasts)
                    self.view?.display(isLoading: false)
                }
            } catch {
                print("DECODING ERROR \(error)")
                DispatchQueue.main.async {
                    self.view?.display(isLoading: false)
                }
            }
        }
        taskPodcasts.resume()
    }
    
    func onSelect(_ podcast: Podcast) {
        print("SELECTED \(podcast)")
    }
}


