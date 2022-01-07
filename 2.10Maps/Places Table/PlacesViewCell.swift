//
//  PlacesViewCell.swift
//  2.10Maps
//
//  Created by Sergii Kotyk on 7/1/22.
//

import UIKit

class PlacesViewCell: UITableViewCell {

    @IBOutlet weak var placeGlyph: UIImageView!
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func cellIn(data: PointOfInterest){
        placeImage.image = data.image
        placeLabel.text = data.title
        placeGlyph.image = data.glyphImage
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
