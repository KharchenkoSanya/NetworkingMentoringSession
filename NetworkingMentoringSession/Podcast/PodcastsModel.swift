import Foundation

struct PodcastsResult: Decodable {
    let podcasts: [Podcast]
}

struct Podcast: Decodable {
    let id: String
    let type: String
    let description: String
    let title: String
}
