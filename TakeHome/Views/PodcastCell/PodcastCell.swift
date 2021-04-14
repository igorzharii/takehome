
import UIKit
import Kingfisher

final class PodcastCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16))
    }
    
    //MARK: - Methods

    public func setUp(forPodcast podcast: Podcast) {
        cellImageView.kf.setImage(with: podcast.images.thumbnail!)
        titleLabel.text = podcast.title
        descriptionLabel.text = podcast.description
        categoryLabel.text = podcast.categoryName
        authorLabel.text = podcast.publisherName
    }
    
    private func setupUI() {
        contentView.layer.cornerRadius = 20
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.masksToBounds = false
        titleLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.adjustsFontSizeToFitWidth = true
        categoryLabel.adjustsFontSizeToFitWidth = true
        authorLabel.adjustsFontSizeToFitWidth = true
    }
}
