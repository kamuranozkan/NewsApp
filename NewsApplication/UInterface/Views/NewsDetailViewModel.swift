

import Foundation

class NewsDetailViewModel {
    var newsRepository = NewsRepository()
    
    func saveNews(news: Article) {
        newsRepository.saveNews(news: news)
    }
}
