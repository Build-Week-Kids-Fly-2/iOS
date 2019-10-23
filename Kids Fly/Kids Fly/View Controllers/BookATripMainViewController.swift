//
//  BookATripMainViewController.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class BookATripMainViewController: UIViewController {
    
    // MARK: - IBOutlets & Properties

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var hiUserLabel: UILabel!
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //firstLaunchChecker()
        performSegue(withIdentifier: "ShowLoginSegue", sender: self)
    }
    
    // MARK: - IBActions & Methods
    
    func firstLaunchChecker() {
        if UserDefaults.isFirstLaunch() {
            performSegue(withIdentifier: "ShowLoginSegue", sender: self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - Extensions

extension BookATripMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCell", for: indexPath) as? DestinationCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
    
    
}
