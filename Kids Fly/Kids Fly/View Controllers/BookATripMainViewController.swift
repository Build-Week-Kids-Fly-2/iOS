//
//  BookATripMainViewController.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit
import CoreData

class BookATripMainViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    // MARK: - IBOutlets & Properties

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var hiUserLabel: UILabel!
    
    let tripController = TripController.shared
    var trip: Trip?
    var trips: [Trip]?
    let token: String? = KeychainWrapper.standard.string(forKey: "token")
    
    var user: UserRepresentation {
        let moc = CoreDataStack.shared.mainContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let users = try moc.fetch(request)
            if let user = users.first {
                return user.userRepresentation
            }
        } catch {
            fatalError("Error performing fetch for user: \(error)")
        }
        return UserRepresentation(email: nil, password: nil, fullName: nil)
    }
    
    //MARK: - Fetched Results Controller
    
    lazy var fetchedResultsController: NSFetchedResultsController<Trip> = {
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()

        // FRCs need at least one sort descriptor. If you are using "sectionNameKeyPath", the first sort descriptor must be the same attribute
        let departureTime = NSSortDescriptor(key: "departureTime", ascending: true)
        fetchRequest.sortDescriptors = [departureTime]

        let moc = CoreDataStack.shared.mainContext

        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)

        frc.delegate = self

        do {
            try frc.performFetch()
        } catch {
            fatalError("Error performing fetch for frc: \(error)")
        }
        self.trips = frc.fetchedObjects
        return frc
    }()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if UserDefaults.isFirstLaunch() && token == nil {
            performSegue(withIdentifier: "ShowLoginSegue", sender: self)
        } else if token == nil {
            performSegue(withIdentifier: "ShowLoginSegue", sender: self)
        } else if user.email == nil {
            performSegue(withIdentifier: "ShowLoginSegue", sender: self)
        }
        
        if token != nil {
            tripController.fetchTripsFromServer {

            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if token != nil {
            tripController.fetchTripsFromServer()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            guard let bookTripVC = segue.destination as? BookTripViewController else { return }
        }
    }
    
    // MARK: NSFetchedResultsControllerDelegate
        private var itemChanges = [(type: NSFetchedResultsChangeType, indexPath: IndexPath?, newIndexPath: IndexPath?)]()
        
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            
            
            switch type {
            case .insert:
                guard let newIndexPath = newIndexPath else { return }
                collectionView.insertItems(at: [newIndexPath])
            case .delete:
                guard let newIndexPath = newIndexPath else { return }
                collectionView.deleteItems(at: [newIndexPath])
            case .update:
                guard let newIndexPath = newIndexPath,
                      let indexPath = indexPath else { return }
                collectionView.moveItem(at: indexPath, to: newIndexPath)
            case .move:
                guard let indexPath = indexPath else { return }
                collectionView.reloadItems(at: [indexPath])
            @unknown default:
                break
            }
            
            itemChanges.append((type: type, indexPath: indexPath, newIndexPath: newIndexPath))
        }
        
        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
        {
            
            if collectionView.numberOfItems(inSection: 0) == 0 {
                collectionView.reloadData()
            }
                // Makes sure labels are *always* updated in the first collectionView cell
                //self.collectionView.reloadItems(at: [IndexPath(item: 0, section: 0)])
                
            collectionView?.performBatchUpdates({
                for change in self.itemChanges {
                    switch change.type {
                        
                    case .insert: self.collectionView?.insertItems(at: [change.newIndexPath!])
                    case .delete: self.collectionView?.deleteItems(at: [change.indexPath!])
                    case .update: self.collectionView?.reloadItems(at: [change.indexPath!])
                    case .move:
                        self.collectionView?.deleteItems(at: [change.indexPath!])
                        self.collectionView?.insertItems(at: [change.newIndexPath!])
                    @unknown default:
                        fatalError()
                    }
                }
                
    //            self.sectionChanges.removeAll()
                self.itemChanges.removeAll()
                
            }, completion: { finished in
                // moved section and item changes from here
            })
        }
}

// MARK: - Extensions

extension BookATripMainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[0].numberOfObjects ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DestinationCell", for: indexPath) as? DestinationCollectionViewCell else { return UICollectionViewCell() }
        let trip = fetchedResultsController.object(at: indexPath)
        cell.trip = trip
        return cell
    }
}




