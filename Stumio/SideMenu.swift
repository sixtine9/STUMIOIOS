
import Foundation
import UIKit

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: SideMenuItem)
    
}

enum SideMenuItem: String, CaseIterable {
    case logo = "logo"
    case home = "Home"
    case places = "lieux"
    case favorites = "favoris"
    case info = "À propos"
}

class MenuController: UITableViewController {

    public var delegate: MenuControllerDelegate?

    private let menuItems: [SideMenuItem]
    private let color = UIColor(red: 35/255.0,
                                green: 72/255.0,
                                blue: 162/255.0,
                                alpha: 1)

    init(with menuItems: [SideMenuItem]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = color
        view.backgroundColor = color
    }

    // Table
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        switch menuItems[indexPath.row] {
        case .logo:
            let cellImg : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: 100))
            cellImg.image = UIImage(named: "white_logo_color_background")
            cell.addSubview(cellImg)
        case .home:
            cell.textLabel?.text = menuItems[indexPath.row].rawValue
            cell.textLabel?.textColor = .white
            cell.imageView?.image = UIImage(named: "home");
            cell.backgroundColor = color
            cell.contentView.backgroundColor = color
        case .places:
            cell.textLabel?.text = menuItems[indexPath.row].rawValue
            cell.textLabel?.textColor = .white
            cell.imageView?.image = UIImage(named: "pin");
            cell.backgroundColor = color
            cell.contentView.backgroundColor = color
        case .favorites:
            cell.textLabel?.text = menuItems[indexPath.row].rawValue
            cell.textLabel?.textColor = .white
            cell.imageView?.image = UIImage(named: "heart");
            cell.backgroundColor = color
            cell.contentView.backgroundColor = color
        case .info:
            cell.textLabel?.text = menuItems[indexPath.row].rawValue
            cell.textLabel?.textColor = .white
            cell.imageView?.image = UIImage(named: "info");
            cell.backgroundColor = color
            cell.contentView.backgroundColor = color
        }
        


        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        // Relay to delegate about menu item selection

        
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }

}

