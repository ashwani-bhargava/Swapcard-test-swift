//
//  ArtistListCollectionViewCell.swift
//  SwapCard_iOS
//
//  Created by Ashwani on 11/03/21.
//

import UIKit
import SDWebImage
class ArtistListCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var artist: ArtistPresentable?
    func setup(artist: ArtistPresentable, bookmarkAction: @escaping (ArtistPresentable) -> Void) {
        self.artist = artist
        titleLabel.text = artist.name
        descriptionLabel.text = artist.disambiguation
        if let urlString = artist.imageURL, let url = URL(string: urlString) {
            iconImageView.sd_setImage(with: url)
        }
        let action = UIAction { (action) in
            bookmarkAction(artist)
        }
        bookmarkButton.addAction(action, for: .touchUpInside)
    }
}
