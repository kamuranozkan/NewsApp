

import Foundation
import RxSwift
import UIKit

class NewsViewModel {
    var newsRepo = NewsRepository()
    var newsList = BehaviorSubject<[Article]>(value: [Article]())
    
    init(){
        newsList = newsRepo.newsList
    }

    func loadNews(){
        newsRepo.loadNews()
    }
    
    func searchNews(word:String){
        newsRepo.searchNews(word: word)
    }
    
    func checkIsSaved(date: String?) -> Bool {
        guard let date else { return false }
        return newsRepo.checkSavedUserDefaults(date: date)
    }
    
    func getCategoryList(word: String) {
        newsRepo.getCategoryNews(word: word)
    }
    
    
    func showNewsDetail(news: Article, root: UIViewController) {
        let storyboard = UIStoryboard(name: "NewsDetail", bundle: nil)
        let newsDetailPage = storyboard.instantiateViewController(withIdentifier: "NewsDetailPage") as! NewsDetailPage
        newsDetailPage.setNews(news: news)
        root.show(newsDetailPage, sender: nil)
    }
}
