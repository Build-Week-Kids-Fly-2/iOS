//
//  DestinationCollectionViewCell.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class DestinationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellBackgroundImageView: UIImageView!
    @IBOutlet weak var destinationNameLabel: UILabel!
    @IBOutlet weak var destinationDateLabel: UILabel!
    @IBOutlet weak var backgroundViewOverContentView: UIView!
    
    let backgrounds: [UIImage] = []
    
    var trip: Trip? {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        styleCell()
        guard let trip = trip else { return }
        destinationNameLabel.text = trip.airport
        destinationDateLabel.text = trip.departureTime
        let randomInt = Int.random(in: 0...4)
        let image = UIImage(named: "Vectorbackground\(randomInt)")
        cellBackgroundImageView.image = image
    }
    
    private func styleCell() {
        backgroundViewOverContentView.layer.cornerRadius = 10
    }
}
