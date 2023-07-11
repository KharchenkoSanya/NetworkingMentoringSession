import Foundation

protocol PodcastsRouter: AnyObject {
    func route(with podcast: Podcast)
}
