

import UIKit

class SignUpPage: UIViewController {

    @IBOutlet weak var signUpImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    private let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 10
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else { return }
        viewModel.saveUser(email: email, password: password)
        self.dismiss(animated: true)
    }
}
