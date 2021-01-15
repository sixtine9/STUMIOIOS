
import UIKit
import Firebase
import GeoFire

class HomeTableView: UITableViewController, CLLocationManagerDelegate {

    var donationGeoFire: GeoFire!
    var donationGeoFireRef: DatabaseReference!
    let locationManager = CLLocationManager()
    var userLocation = CLLocationCoordinate2D()
    
    var functionCalled = false
    
    var restaux : [Restaurant] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        if CLLocationManager.locationServicesEnabled() {
                print("yes")
            }
            else {
                print("no")
            }
        
        donationGeoFireRef = Database.database().reference().child("restaurantsId")
        donationGeoFire = GeoFire(firebaseRef: donationGeoFireRef)
        

        
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        
     
        
    }
    
    func execQuery(){
        
        
        
        
        if(!functionCalled){
        let circleQuery = donationGeoFire.query(at: CLLocation.init(latitude: userLocation.latitude, longitude: userLocation.longitude) , withRadius: 40)

        
        _ = circleQuery.observe(.keyEntered, with: { (key: String!, location: CLLocation!) in
            
                
                let donationRef = Database.database().reference().child("restaurants").child(key)
                donationRef.observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let title = value?["title"] ?? "Error"
                    let adress = value?["adresse"] ?? "Error"
                    self.restaux.append(Restaurant.init(title: title as! String, adress: adress as! String, coordinate: location))
                    
                    print(title)
                    
                 
                    
                })
            })
        }
        functionCalled = true
        
        self.tableView.reloadData()
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        

        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        userLocation = locValue
        


        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        execQuery()
        
    }
 

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaux.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("salut")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeCell
        

        cell.backgroundImg.contentMode = UIView.ContentMode.scaleAspectFill
        cell.backgroundImg.clipsToBounds = true;
        cell.backgroundImg.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        cell.backgroundImg.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        cell.backgroundImg.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        cell.backgroundImg.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        cell.titlesStack.bottomAnchor.constraint(equalTo: cell.backgroundImg.bottomAnchor).isActive = true
        cell.titlesStack.leadingAnchor.constraint(equalTo: cell.backgroundImg.leadingAnchor).isActive = true;

        cell.backgroundImg.image = UIImage(named: "1")
        cell.titleLbl.text = restaux[indexPath.row].title
        cell.titleLocation.text = restaux[indexPath.row].adress

        
        cell.titleLbl.layer.backgroundColor = UIColor.black.withAlphaComponent(0.3).cgColor

        //cell.titleLbl.layer.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        /*let myView = UIView.init(frame: cell.bounds)
        myView.layer.backgroundColor = UIColor.darkGray.cgColor
        myView.layer.opacity = 0.3
        cell.backgroundImg.addSubview(myView)
        cell.backgroundImg.layer.backgroundColor = UIColor.black.cgColor
        cell.backgroundImg.clipsToBounds = true*/

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIView {
func addoverlay(color: UIColor = .black,alpha : CGFloat = 0.6) {
    let overlay = UIView()
    overlay.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    overlay.frame = bounds
    overlay.backgroundColor = color
    overlay.alpha = alpha
    addSubview(overlay)
    }
    //This function will add a layer on any `UIView` to make that `UIView` look darkened
}
