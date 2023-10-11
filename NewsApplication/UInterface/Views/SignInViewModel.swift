
import UIKit

class SignInViewModel {
    let authRepository = AuthRepository()
    
    func signInButtonTapped(email: String, password: String, root: UIViewController) {
        authRepository.login(email: email, password: password) { [weak self] success in
            guard let self, success else { return }
            self.presentSignIn(root: root)
        }
    }
    
    func signUpButtonTapped(root: UIViewController) {
        presentSignUp(root: root)
    }
}

extension SignInViewModel {
    private func presentSignUp(root: UIViewController) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        let signUpPage = storyboard.instantiateViewController(withIdentifier: "SignUp") as! SignUpPage
        root.present(signUpPage, animated: true, completion: nil)
    }
    
    private func presentSignIn(root: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInPage = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        signInPage.modalPresentationStyle = .fullScreen
        root.show(signInPage, sender: nil)
    }
}
