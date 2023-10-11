

import UIKit
import Kingfisher

class NewsDetailPage: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var saveNews: UIButton!
    
    private var news: Article?
    private var viewModel = NewsDetailViewModel()
    var isSaved = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setContent()
        setButtonVisibility()
        
        saveNews.layer.cornerRadius = 5
        titleLabel.layer.borderWidth = 1
        titleLabel.layer.borderColor = UIColor.lightGray.cgColor
        titleLabel.layer.cornerRadius = 5
        descriptionLabel.layer.borderWidth = 0.8
        descriptionLabel.layer.borderColor = UIColor.lightGray.cgColor
        descriptionLabel.layer.cornerRadius = 5
        authorLabel.layer.borderWidth = 1
        authorLabel.layer.borderColor = UIColor.lightGray.cgColor
        authorLabel.layer.cornerRadius = 5
        imageView.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setButtonVisibility()
    }

    
    func setContent() {
        guard let news else { return }
        if let image = news.urlToImage,
           let imageUrl = URL(string: image) {
            imageView.kf.setImage(with: imageUrl)
        }
        titleLabel.text = news.title
        descriptionLabel.text = news.description
        authorLabel.text = news.author
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let news else { return }
        viewModel.saveNews(news: news)
        
        let alertController = UIAlertController(title: "", message: "The News is added to Favorite News!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok!", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func setNews(news: Article) {
        self.news = news
    }
    
    private func setButtonVisibility() {
        saveNews.isHidden = isSaved
    }
}
