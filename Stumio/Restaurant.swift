
import UIKit
import CoreLocation

class Restaurant{
    var title: String!
    var adress: String!
    var coordinate: CLLocation!
    
    
    
    init(title: String, adress: String, coordinate: CLLocation) {
        self.title = title
        self.adress = adress
        self.coordinate = coordinate
    }
}
