
import UIKit

protocol CellProtocol{
    func saveNews(indexPath:IndexPath)
}

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var savedButton: UIButton!
    
    var cellProtocol:CellProtocol?
    var indexPath:IndexPath?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
    
    @IBAction func saveButton(_ sender: Any) {
        cellProtocol?.saveNews(indexPath: indexPath!)
    }
    
    func setButtonVisibility(isHidden: Bool) {
        savedButton.isHidden = isHidden
    }
}
