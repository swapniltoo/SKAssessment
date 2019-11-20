
import UIKit

class SkTableViewCell: UITableViewCell {

    @IBOutlet var img  : UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var byline: UILabel!
    @IBOutlet weak var published_date: UILabel!


    var cellData : [String:Any] = [:]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
