//
//  MasterViewControllerTableViewCell.swift
//  FlickerTest
//


import UIKit
import Kingfisher

// MARK: MasterViewControllerTableViewCell

class MasterViewControllerTableViewCell: UITableViewCell {

    @IBOutlet var flickerImage: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var date: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()

        title.text = ""
        date.text = ""
        flickerImage.image = nil
    }

    func setUpCellWithObject(object: FlickerObject) {
        title.text = object.title
        date.text = object.dateTaken
        // Uses a framework for downloading and caching images
        flickerImage.kf_setImageWithURL(NSURL(string: object.mediaString)!, placeholderImage: UIImage(named:"Placeholder"))

    }
}
