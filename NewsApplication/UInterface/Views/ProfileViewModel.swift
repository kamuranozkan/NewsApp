
import UIKit
import FirebaseAuth
import RxSwift

class ProfileViewModel {
    var authRepository = AuthRepository()
    
    func getCurrentUser() -> User? {
        authRepository.getCurrentUser()
    }
    
    func logout(root: UIViewController) {
        authRepository.logout()
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let signInPage = storyboard.instantiateViewController(withIdentifier: "SignInPage") as! SignInPage
        
        if let window = UIApplication.shared.keyWindow {
            window.rootViewController = nil
            window.rootViewController = signInPage
            window.makeKeyAndVisible()
        }
    }
}
