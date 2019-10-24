//
//  DestinationTableViewCell.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/24/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class DestinationTableViewCell: UITableViewCell {

    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var destinationImageView: UIImageView!
    @IBOutlet weak var imageContainerView: UIView!
    
    var trip: Trip? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        styleCell()
        guard let trip = trip else { return }
        destinationLabel.text = trip.airport
        departureDateLabel.text = trip.departureTime
        let randomInt = Int.random(in: 0...4)
        let image = UIImage(named: "Vectorbackground\(randomInt)")
        destinationImageView.image = image
    }
    
    private func styleCell() {
        imageContainerView.layer.cornerRadius = 10
    }
}
