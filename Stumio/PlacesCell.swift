
import UIKit

class PlacesCell: UITableViewCell {
    
    @IBOutlet weak var locationLbl: UILabel!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var cellStackView: UIStackView!
    @IBOutlet weak var titleStack: UIStackView!
    @IBOutlet weak var restoImg: UIImageView!
    var separatorView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0.6))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
