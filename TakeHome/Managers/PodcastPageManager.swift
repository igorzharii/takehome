
import Foundation

final class PodcastPageManager {

    private var podcastCurrentPage = 1
    
    public func getCurrentPage() -> Int {
        return podcastCurrentPage
    }
    
    public func increaseCurrentPage() {
        podcastCurrentPage += 1
    }
    
    public func resetCurrentPage() {
        podcastCurrentPage = 1
    }
}
