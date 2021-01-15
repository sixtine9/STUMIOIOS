
import UIKit
import Firebase
import GeoFire

class PlacesTableView: UITableViewController, CLLocationManagerDelegate {
    
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
        

        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        

        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        if(!functionCalled){
            userLocation = locValue
        }
        


        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        execQuery()
        
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
                    
                 
                    print("wsh")
                })
            })
        }
        functionCalled = true
        
        self.tableView.reloadData()
        
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placesCell", for: indexPath) as! PlacesCell
        
        cell.restoImg.image = UIImage(named: "2")
        
        cell.addSubview(cell.separatorView)
        cell.separatorView.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
        cell.separatorView.layer.backgroundColor = UIColor.white.withAlphaComponent(0.5).cgColor
        
        
        
        let durationLabel: UILabel = {
            let label = UILabel()
            label.text = "4,5 km"
            label.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
            label.textAlignment = NSTextAlignment.right
            label.numberOfLines = 1
            label.textColor = UIColor.white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        var distance = restaux[indexPath.row].coordinate.distance(from: CLLocation.init(latitude: userLocation.latitude, longitude: userLocation.longitude))
        
        distance /= 1000
        
        let s = NSString(format: "%,2f", distance)

        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        // Configure the number formatter to your liking
        let s2 = nf.string(from: NSNumber(value: distance))
        
        cell.restoImg.image = UIImage(named: "1")
        cell.title.text = restaux[indexPath.row].title
        cell.locationLbl.text = restaux[indexPath.row].adress
        durationLabel.text = s2! + " km"
        
        cell.restoImg.addSubview(durationLabel)
        
        durationLabel.bottomAnchor.constraint(equalTo: cell.restoImg.bottomAnchor).isActive = true
        durationLabel.leftAnchor.constraint(equalTo: cell.restoImg.leftAnchor).isActive = true
        durationLabel.layer.backgroundColor = UIColor.black.withAlphaComponent(0.4).cgColor
        

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
        return 225
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
