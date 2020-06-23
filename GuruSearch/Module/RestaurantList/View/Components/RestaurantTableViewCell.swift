//
//  RestaurantTableViewCell.swift
//  GuruSearch
//
//  Created by okudera on 2020/06/22.
//  Copyright © 2020 yuoku. All rights reserved.
//

import UIKit
import Nuke

final class RestaurantTableViewCell: UITableViewCell {

    @IBOutlet private weak var mainThumbnailImageView: UIImageView!
    @IBOutlet private weak var sub1ThumbnailImageView: UIImageView!
    @IBOutlet weak var detailButton: MaterialButton! {
        didSet {
            detailButton.titleLabel?.lineBreakMode = .byWordWrapping
            detailButton.titleLabel?.numberOfLines = 2
            detailButton.setTitle("ShopDetail".localized(), for: .normal)
            detailButton.setTitle("ShopDetailDisabled".localized(), for: .disabled)
        }
    }
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var accessLabel: UILabel!
    @IBOutlet private weak var budgetLabel: UILabel!
    @IBOutlet private weak var openTimeLabel: UILabel!
    @IBOutlet private weak var telLabel: UILabel!
    @IBOutlet private weak var prTextView: UITextView! {
        didSet {
            prTextView.textContainer.lineBreakMode = .byTruncatingTail
        }
    }

    private(set) var restaurant: Restaurant?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        mainThumbnailImageView.image = UIImage(named: "restaurant_l")
        sub1ThumbnailImageView.image = UIImage(named: "restaurant")
    }

    func setRestaurant(_ restaurant: Restaurant) {
        self.restaurant = restaurant
        mainThumbnailImageView.loadImage(urlString: restaurant.imageUrl.shopImage1)
        sub1ThumbnailImageView.loadImage(urlString: restaurant.imageUrl.shopImage2)

        let access = restaurant.access
        if let line = access.line, let station = access.station, let walk = access.walk {
            var accessText = line
            accessText.append(" ")
            accessText.append(station)
            if let stationExit = restaurant.access.stationExit, !stationExit.isEmpty {
                accessText.append("（")
                accessText.append(stationExit)
                accessText.append("）")
            }
            accessText.append(" ")
            accessText.append(walk.value)
            accessText.append("Minute".localized())
            accessLabel.text = accessText
        }

        if let note = restaurant.access.note, !note.isEmpty {
            accessLabel.text?.append("（" + note + "）")
        }

        if let url = restaurant.url, !url.isEmpty {
            self.detailButton.isEnabled = true
            self.detailButton.backgroundColor = #colorLiteral(red: 1, green: 0.2509803922, blue: 0.4117647059, alpha: 1)
        }
        else {
            self.detailButton.isEnabled = false
            self.detailButton.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        }

        nameLabel.text = restaurant.name
        if let budgetValue = Int(restaurant.budget?.value ?? "") {
            budgetLabel.text = budgetValue.withCommas() + "Yen".localized()
        }
        openTimeLabel.text = restaurant.opentime?.trimmingCharacters(in: .whitespacesAndNewlines)
        telLabel.text = restaurant.tel
        prTextView.text = restaurant.pr.prLong
    }

    @IBAction private func tappedDetailButton(_ sender: MaterialButton) {
        NotificationCenter.default.post(name: .tappedDetailButton, object: restaurant?.url)
    }
}
