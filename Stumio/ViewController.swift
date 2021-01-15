
import UIKit
import Firebase
import GeoFire
import CoreLocation

class ViewController: UIViewController {
    
    var menuIsHidden = true;
    
    @IBOutlet weak var sideView: UIView!
    
    @IBOutlet weak var menuLeading: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        let img : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        img.image = UIImage(named: "white_logo_transparent_background")
        
        img.contentMode = UIView.ContentMode.scaleAspectFit
        img.clipsToBounds = true
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "white_logo_transparent_background"))
        menuLeading.constant = -240
        sideView.layer.shadowOpacity = 0.5
        sideView.layer.shadowRadius = 10
        self.navigationController?.isNavigationBarHidden = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "burger")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action:#selector(hamburgerTapped(_:)))
        
        
        let ref = Database.database().reference().child("restaurants").childByAutoId()
        let geoFireRef = Database.database().reference().child("restaurantsId")
        let geoFire = GeoFire(firebaseRef: geoFireRef)
        
        ref.setValue(["title": "Sake Lover", "adresse" : "83 Rue de Turbigo, 75003, Paris"])
        
        let address = "83 Rue de Turbigo, 75003, Paris"

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            let placemark = placemarks?.first
            let lat = placemark?.location?.coordinate.latitude
            let lon = placemark?.location?.coordinate.longitude
            geoFire.setLocation(CLLocation(latitude: lat ?? 48, longitude: lon ?? 28), forKey: ref.key!)
        }
        
        
        
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
    
}

