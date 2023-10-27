import UIKit
import Kingfisher

class MainGifCell: UICollectionViewCell {
    
    @IBOutlet weak var gifImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        gifImage.contentMode = .scaleToFill
        gifImage.layer.cornerRadius = 15
    }
    func configureCell(withUrl gifUrl: URL){
        gifImage.kf.indicatorType = .activity
        gifImage.kf.setImage(
            with: gifUrl,
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}
