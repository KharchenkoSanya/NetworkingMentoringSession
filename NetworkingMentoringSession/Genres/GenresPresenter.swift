
import Foundation
	
protocol GenresView: AnyObject {
    func display(_ genres: [Genre])
    func display(isLoading: Bool)
}

class GenresPresenter {
    weak var view: GenresView?
    
    @objc
    func getGenres() {
        view?.display(isLoading: true)
        var request = URLRequest(url: URL(string: "https://listen-api-test.listennotes.com/api/v2/genres")!)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            do {
                let result = try JSONDecoder().decode(GenresResult.self, from: data)
                print("DECODING RESULT \(result)")
                DispatchQueue.main.async {
                    self.view?.display(result.genres)
                    self.view?.display(isLoading: false)
                }
            } catch {
                print("DECODING ERROR \(error)")
                DispatchQueue.main.async {
                    self.view?.display(isLoading: false)
                }
            }
        }
        task.resume()
    }
    func onSelect(_ genre: Genre) {
        print("SELECTED \(genre)")
    }
}
