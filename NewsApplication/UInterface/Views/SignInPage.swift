
import UIKit

class SignInPage: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signinImage: UIImageView!
    private let viewModel = SignInViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signInButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        viewModel.signInButtonTapped(email: email, password: password, root: self)
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        viewModel.signUpButtonTapped(root: self)
    }
    
}
