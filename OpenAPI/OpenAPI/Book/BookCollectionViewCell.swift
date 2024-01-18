//
//  BookCollectionViewCell.swift
//  OpenAPI
//
//  Created by 박희지 on 1/18/24.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet var cellView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureUI()
    }
    
    override func prepareForReuse() {
        cellView.setRandomBackgroundColor()
    }
}

// MARK: - Custom UI
extension BookCollectionViewCell {
    func configureUI() {
        cellView.setRandomBackgroundColor()
        cellView.setCornerRadius(style: .medium)
        
        titleLabel.font = .boldSystemFont(ofSize: 17)
        
        thumbnailImageView.contentMode = .scaleAspectFill
    }
    
    func bindItem(doc: Document?) {
        guard let doc else { return }
        
        titleLabel.text = doc.title
        
        let url = URL(string: doc.thumbnail)!
        thumbnailImageView.kf.setImage(with: url)
        
        authorLabel.text = doc.authors.first
        
        priceLabel.text = "₩" + doc.price.setComma()
    }
}
