import UIKit

class LoadingPage: UIViewController {
    private let viewModel = LoadingViewModel()

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicator.startAnimating()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.onboarding(viewController: self)

    }
}
