import UIKit
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  @IBOutlet weak var tableView: UITableView!
  var viewControllers: [UIViewController] = []
  var hamburgerViewController: HamburgerViewController!
  private var profileNavigationController: UIViewController!
  private var timelineNavigationController: UIViewController!
  private var mentionsNavigationController: UIViewController!
  
  let titles = ["Profile", "Timeline", "Metions", "Logout"]
  
  override func viewDidLoad() {
      super.viewDidLoad()
      tableView.delegate = self
      tableView.dataSource = self
      
      let storyboard = UIStoryboard(name: "Main", bundle: nil)
      profileNavigationController = storyboard.instantiateViewController(withIdentifier: "ProfileNavigationController")
      timelineNavigationController = storyboard.instantiateViewController(withIdentifier: "TimelineNavigationController")
      mentionsNavigationController = storyboard.instantiateViewController(withIdentifier: "MentionsNavigationController")
      
      viewControllers.append(profileNavigationController)
      viewControllers.append(timelineNavigationController)
      viewControllers.append(mentionsNavigationController)
      
      hamburgerViewController.contentViewController = timelineNavigationController
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuCell
    
    cell.menuLabel.text = titles[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    tableView.deselectRow(at: indexPath, animated: true)
  
    if indexPath.row == titles.index(of: "Logout") {
      TwitterClient.sharedInstance?.logout()
      hamburgerViewController.dismiss(animated: true)
    } else {
      hamburgerViewController.contentViewController = viewControllers[indexPath.row]
    }

  }

}
