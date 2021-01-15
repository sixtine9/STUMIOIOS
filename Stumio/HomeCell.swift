
import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var backgroundImg: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var titleLocation: UILabel!
    
    @IBOutlet weak var titlesStack: UIStackView!
    
    var backView : UIView! = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
