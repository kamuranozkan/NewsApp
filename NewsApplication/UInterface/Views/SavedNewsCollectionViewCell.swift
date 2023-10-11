
import UIKit

protocol SavedNewsCellProtocol {
    func deleteNews(indexPath: IndexPath)
}

class SavedNewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    
    var cellProtocol: SavedNewsCellProtocol?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        deleteButtonOutlet.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        cellProtocol?.deleteNews(indexPath: indexPath!)
        
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var responder: UIResponder? = self
        while let nextResponder = responder?.next {
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
            responder = nextResponder
        }
        return nil
    }
}
