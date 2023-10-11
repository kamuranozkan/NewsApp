
import Foundation
import RxSwift
import UIKit

class SavedNewsViewModel {
    var newsRepository = NewsRepository()
    var savedNewsList = BehaviorSubject<[Article]>(value: [Article]())
    
    init(){
        savedNewsList = newsRepository.savedNewsList
    }
    
    func loadSavedNews() {
        newsRepository.getSavedNews()
    }
    
    func deleteSavedNews(news: Article) {
        guard let date = news.publishedAt else { return }
        newsRepository.deleteSavedNews(date: date)
    }
    
    func searchNews(word: String){
        newsRepository.searchSavedNews(word: word)
    }
    
    
    func showNewsDetail(news: Article, root: UIViewController) {
        let storyboard = UIStoryboard(name: "NewsDetail", bundle: nil)
        let newsDetailPage = storyboard.instantiateViewController(withIdentifier: "NewsDetailPage") as! NewsDetailPage
        newsDetailPage.setNews(news: news)
        newsDetailPage.isSaved = true
        root.show(newsDetailPage, sender: nil)
    }
}
