import UIKit

class HamburgerViewController: UIViewController {
  @IBOutlet weak var menuView: UIView!
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
  var originalLeftMargin: CGFloat!
  var menuViewController: UIViewController!{
    didSet{
      view.layoutIfNeeded()
      menuView.addSubview(menuViewController.view)
    }
  }
  var contentViewController: UIViewController!{
    didSet(oldContentViewController){
      view.layoutIfNeeded()
      
      if oldContentViewController != nil{
        oldContentViewController.willMove(toParentViewController: nil)
        oldContentViewController.view.removeFromSuperview()
        oldContentViewController.didMove(toParentViewController: nil)
      }
      contentViewController.willMove(toParentViewController: self)
      contentView.addSubview(contentViewController.view)
      contentViewController.didMove(toParentViewController: self)
      UIView.animate(withDuration: 0.3) { 
        self.leftMarginConstraint.constant = 0
        self.view.layoutIfNeeded()
      }
    }
  }
  override func viewDidLoad() {
        super.viewDidLoad()
        let menuViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        menuViewController.hamburgerViewController = self
        self.menuViewController = menuViewController
    }
  @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
    let translation = sender.translation(in: view)
    let velocity = sender.velocity(in: view)
    
    if sender.state == .began{
      originalLeftMargin = leftMarginConstraint.constant
    }else if sender.state == .changed{
      leftMarginConstraint.constant = originalLeftMargin + translation.x
    }else if sender.state == .ended{
      UIView.animate(withDuration: 0.3, animations: {
        if velocity.x > 0 {
          //opening
          self.leftMarginConstraint.constant = self.view.frame.size.width/2
        }else{
          //closing
          self.leftMarginConstraint.constant = 0
        }
        self.view.layoutIfNeeded()
      })
    }
  }
}
