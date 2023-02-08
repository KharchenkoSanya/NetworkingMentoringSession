import UIKit

class EpisodesCell: UITableViewCell {
    @IBOutlet private weak var pubDateMsLabel: UILabel!
    @IBOutlet private weak var titleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with episode: Episode) {
        self.titleLable.text = episode.title
        self.pubDateMsLabel.text = String(episode.pubDateMs)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
