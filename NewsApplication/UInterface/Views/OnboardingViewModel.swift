

import UIKit

class OnboardingViewModel {
    func presentSignIn(root: UIViewController) {
        let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
        let mainPage = storyboard.instantiateViewController(withIdentifier: "SignInPage") as! SignInPage
        mainPage.modalPresentationStyle = .fullScreen
        root.show(mainPage, sender: nil)
    }
}
