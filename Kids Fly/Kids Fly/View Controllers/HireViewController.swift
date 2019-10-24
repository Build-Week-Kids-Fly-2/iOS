//
//  HireViewController.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/22/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class HireViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var attendantNameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var jobsCompletedLabel: UILabel!
    
    var trip: Trip?
    
    let assistants: [Assistant] = [
        Assistant(name: "David", languages: ["English, Spanish"], abilities: ["Heavy-Lifting", "Good with children"], backgroundCheck: "Background Checked", image: UIImage(named: "VectorDavid")!.pngData()!, jobComplete: "53"),
        Assistant(name: "Derrick", languages: ["English, French"], abilities: ["Heavy-Lifting", "Jokes upon request"], backgroundCheck: "Background Checked", image: UIImage(named: "VectorDerrick")!.pngData()!, jobComplete: "132"),
        Assistant(name: "Thomas", languages: ["English"], abilities: ["Multitasking", "Professional getting of things"], backgroundCheck: "Background Checked", image: UIImage(named: "VectorThomas")!.pngData()!, jobComplete: "43")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialAssistant()
    }
    

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ReviewTripSegue" {
            guard let reviewVC = segue.destination as? ReviewTripViewController,
                let indexPath = collectionView.indexPathsForSelectedItems?.first else { return }
            reviewVC.trip = self.trip
            print("\(trip?.airport)")
            reviewVC.assistant = assistants[indexPath.item]
        }
    }
     
    
    func initialAssistant() {
        let assistant = assistants[0]
        attendantNameLabel.text = assistant.name
        var languages = "Knows"
        for language in assistant.languages {
            languages.append(contentsOf: " \(language)")
        }
        languageLabel.text = languages
        var abilities = ""
        
        for ability in assistant.abilities {
            abilities.append(contentsOf: ability)
        }
        abilitiesLabel.text = abilities
        jobsCompletedLabel.text = "\(assistant.jobComplete) jobs completed"
    }
    
}

extension HireViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        assistants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AssistantCell", for: indexPath) as? AssistantCollectionViewCell else  { return UICollectionViewCell()}
        let image = UIImage(data: assistants[indexPath.item].image)
        cell.AssistantImageView.image = image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assistant = assistants[indexPath.item]
        attendantNameLabel.text = assistant.name
        var languages = "Knows"
        for language in assistant.languages {
            languages.append(contentsOf: " \(language)")
        }
        languageLabel.text = languages
        var abilities = ""
        
        for ability in assistant.abilities {
            abilities.append(contentsOf: ability)
        }
        abilitiesLabel.text = abilities
        jobsCompletedLabel.text = "\(assistant.jobComplete) jobs completed"
        
    }
}
