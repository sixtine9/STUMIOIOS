
import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var sideView: UIView!
    
    @IBOutlet weak var menuLeading: NSLayoutConstraint!
    var menuIsHidden = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menuLeading.constant = -240
        sideView.layer.shadowOpacity = 0.5
        sideView.layer.shadowRadius = 10
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func screenTapped(_ sender: Any) {
        self.menuLeading.constant = -240

        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
        
        menuIsHidden = true
    }
    
    @IBAction func hamburgerTapped(_ sender: Any) {
        if(menuIsHidden){
            

                self.menuLeading.constant = 0
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            
            
        }else{
            self.menuLeading.constant = -240

            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
                
                
            
            
        }
        
        menuIsHidden = !menuIsHidden
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
