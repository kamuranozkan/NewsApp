
import UIKit

protocol CategoryNewsProtocol {
    func getCategoryNews(category: String)
}

class SideMenuPage: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = SideMenuViewModel()
    let viewModel2 = NewsViewModel()
    let categories =  ["Genereal", "Entertainment", "Business", "Health", "Science", "Sports", "Technology"]
    var categoryNews: CategoryNewsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SideMenuPage: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.nameLabel?.text = categories[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let title = categories[indexPath.row]
        categoryNews?.getCategoryNews(category: title)
    }
}
