import Foundation

protocol EpisodesRouter: AnyObject {
    func route(with episode: Episode)
}
