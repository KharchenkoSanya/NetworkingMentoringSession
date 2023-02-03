import Foundation

struct EpisodesResult: Decodable {
    let episodes: [Episode]
}

struct Episode: Decodable {
    let id: String
    let image: String
    let title: String
    let pubDateMs: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case image
        case title
        case pubDateMs = "pub_date_ms"
    }
}
