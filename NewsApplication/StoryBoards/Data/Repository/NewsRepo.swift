
import Foundation
import RxSwift
import Alamofire
import Firebase


class NewsRepo {
    var newsList = BehaviorSubject<[Article]>(value: [Article]())
    var savedNewsList = BehaviorSubject<[Article]>(value: [Article]())
    
    private var tempNewsList = [Article]()
    private var tempSavedNewsList = [Article]()
    private var network = Network()
    
    private var url = "https://newsapi.org/v2/top-headlines?category=general&apiKey=c8597e01e250430da1464e7388cab7e2&pageSize=100&language=en"
    
    let ref = Database.database().reference()

    func loadNews(){
        network.fetchCategoryNews(url: url) { response in
            switch response {
            case .success(let newsResponse):
                self.tempNewsList = newsResponse.articles
                self.newsList.onNext(newsResponse.articles)
                print(newsResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func searchNews(word: String) {
        if word.isEmpty {
            newsList.onNext(tempNewsList)
            return
        }
        
        let filteredList = tempNewsList.filter {
            if let description = $0.description {
                return description.lowercased().contains(word.lowercased())
            }
            return false
        }
        newsList.onNext(filteredList)
    }
    
    func searchSavedNews(word: String) {
        if word.isEmpty {
            savedNewsList.onNext(tempSavedNewsList)
            return
        }
        
        let filteredList = tempSavedNewsList.filter {
            if let description = $0.description {
                return description.lowercased().contains(word.lowercased())
            }
            return false
        }
        savedNewsList.onNext(filteredList)
    }
}

extension NewsRepo {
    func getSavedNews() {
        ref.child("article").observeSingleEvent(of: .value) { [weak self] (snapshot) in
            var articles = [Article]()
            if let value = snapshot.value as? [String: [String: Any]] {
                articles = self?.convertJSONToArticle(jsonDictionary: value) ?? []
            }
            self?.tempSavedNewsList = articles
            self?.savedNewsList.onNext(articles)
        }
    }
    
    func saveNews(news: Article) {
        guard let dictionary = makeNewsDictionaryFormat(news: news),
              let date = news.publishedAt else { return }
        
        let articleRef = ref.child("article").child(date)
        articleRef.setValue(dictionary) { [weak self] (error, _) in
            if let error = error {
                print("Kullanıcı eklenemedi.")
            }
            self?.getSavedNews()
            self?.saveUserDefaults(date: date)
            self?.loadNews()
        }
    }
    
    func deleteSavedNews(date: String) {
        let articleRef = ref.child("article").child(date)

        articleRef.removeValue { [weak self] (error, _) in
            self?.getSavedNews()
            self?.loadNews()
            self?.deleteUserDefaults(date: date)
        }
    }
}

extension NewsRepo {
    private func saveUserDefaults(date: String) {
        var idArray = UserDefaults.standard.array(forKey: "SavedNewsIDs") as? [String] ?? []
        idArray.append(date)
        UserDefaults.standard.set(idArray, forKey: "SavedNewsIDs")
    }
    
    private func deleteUserDefaults(date: String) {
        var idArray = UserDefaults.standard.array(forKey: "SavedNewsIDs") as? [String] ?? []
        idArray = idArray.filter { $0 != date }
        UserDefaults.standard.set(idArray, forKey: "SavedNewsIDs")
    }
    
    func checkSavedUserDefaults(date: String) -> Bool {
        var idArray = UserDefaults.standard.array(forKey: "SavedNewsIDs") as? [String] ?? []
        let isSaved = idArray.contains(date)
        return isSaved
    }
}

extension NewsRepo {
    func getCategoryNews(word: String) {
        url = "https://newsapi.org/v2/top-headlines?category=\(word)&apiKey=c8597e01e250430da1464e7388cab7e2&pageSize=100&language=en"
        network.fetchCategoryNews(url: url) { response in
            switch response {
            case .success(let newsResponse):
                self.tempNewsList = newsResponse.articles
                self.newsList.onNext(newsResponse.articles)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension NewsRepo {
    private func makeNewsDictionaryFormat(news: Article) -> [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(news)
            if let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                return dictionary
            }
        } catch {
            print("Hata: \(error)")
        }
        return nil
    }
    
    private func convertJSONToArticle(jsonDictionary: [String: [String: Any]]) -> [Article] {
        var articles: [Article] = []
        let decoder = JSONDecoder()

        for (_, value) in jsonDictionary {
            if let jsonData = try? JSONSerialization.data(withJSONObject: value, options: []) {
                do {
                    let article = try decoder.decode(Article.self, from: jsonData)
                    articles.append(article)
                } catch {
                    print("JSON çözümleme hatası: \(error)")
                }
            }
        }
        tempSavedNewsList = articles
        savedNewsList.onNext(articles)
        
        return articles
    }
}
