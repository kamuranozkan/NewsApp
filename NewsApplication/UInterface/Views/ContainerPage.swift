import UIKit

class ContainerPage: UIViewController {
    
    private enum MenuState {
        case opened
        case closed
    }
    
    private var state: MenuState = .closed
    private var sideMenu = SideMenuPage()
    private var news = NewsPage()

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC()
        news.tabbarProtocol = self
    }
    
    private func addChildVC() {
        var storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let sideMenu = storyboard.instantiateViewController(withIdentifier: "SideMenuPage") as! SideMenuPage
        addChild(sideMenu)
        view.addSubview(sideMenu.view)
        self.sideMenu = sideMenu
        sideMenu.didMove(toParent: self)
        
        storyboard = UIStoryboard(name: "News", bundle: nil)
        let news = storyboard.instantiateViewController(withIdentifier: "News") as! NewsPage
        addChild(news)
        view.addSubview(news.view)
        self.news = news
        
        sideMenu.categoryNews = news
    }

}

extension ContainerPage: TabbarProtocol {
    func tabbarTapped() {
        switch state {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.news.view.frame.origin.x = self.news.view.frame.size.width - 100
            } completion: { done in
                self.state = .opened
            }
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.news.view.frame.origin.x = 0
            } completion: { done in
                self.state = .closed
            }
        }
    }
}
