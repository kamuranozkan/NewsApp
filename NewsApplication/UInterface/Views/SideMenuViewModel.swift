
import Foundation

class SideMenuViewModel {
    let newsRepository = NewsRepository()
    
    func getCategoryList(word: String) {
        newsRepository.getCategoryNews(word: word)
    }
}
