
import UIKit

class LoadingViewModel {
    private let authRepository = AuthRepository()
    
    func onboarding(viewController: UIViewController) {
        if let user = authRepository.getCurrentUser() {
            presentSignIn(root: viewController)
        } else {
            presentOnboarding(root: viewController)
        }
    }

    private func presentSignIn(root: UIViewController) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signInPage = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        signInPage.modalPresentationStyle = .fullScreen
        root.show(signInPage, sender: nil)
    }

    private func presentOnboarding(root: UIViewController) {
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let mainPage = storyboard.instantiateViewController(withIdentifier: "OnboardingPage") as! OnboardingPage
        mainPage.modalPresentationStyle = .fullScreen
        root.show(mainPage, sender: nil)
    }
}
