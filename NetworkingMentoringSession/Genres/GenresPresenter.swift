import Foundation

protocol GenresView: AnyObject {
    func display(_ genres: [Genre])
    func display(isLoading: Bool)
}

final class GenresPresenter {
    weak var view: GenresView?
    
    func getGenres() {
        view?.display(isLoading: true)
        var requestGenres = URLRequest(url: URL(string: "https://listen-api-test.listennotes.com/api/v2/genres")!)
        requestGenres.httpMethod = "GET"
        let sessionGenres = URLSession(configuration: .default)
        let taskGenres = sessionGenres.dataTask(with: requestGenres) { data, _, _ in
            guard let data = data else { return }
            do {
                let resultGenres = try JSONDecoder().decode(GenresResult.self, from: data)
                DispatchQueue.main.async {
                    self.view?.display(resultGenres.genres)
                    self.view?.display(isLoading: false)
                }
            } catch {
                DispatchQueue.main.async {
                    self.view?.display(isLoading: false)
                }
            }
        }
        taskGenres.resume()
    }
}
