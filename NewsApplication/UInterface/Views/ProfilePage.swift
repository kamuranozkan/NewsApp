

import UIKit

class ProfilePage: UIViewController {

    @IBOutlet weak var profilePageImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    private var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.layer.cornerRadius = 5
        surnameLabel.layer.cornerRadius = 5
        nameLabel.layer.cornerRadius = 5
        emailLabel.layer.cornerRadius = 5
        phoneNumberLabel.layer.cornerRadius = 5
        logoutButton.layer.cornerRadius = 10
        setContent()
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        viewModel.logout(root: self)
    }
    
    func setContent() {
        guard let user = viewModel.getCurrentUser() else { return }
        emailLabel.text = user.email
    }
}
