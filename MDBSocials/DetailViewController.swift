//
//  DetailViewController.swift
//  MDBSocials
//
//  Created by Amy on 2/21/17.
//  Copyright © 2017 Amy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class DetailViewController: UIViewController {
    
    
    
   
    static var currentEvent : Social!
   
    var eventView : UIImageView!
    var poster : UILabel!
    var interestedButton : UIButton!
    var eventName: UILabel!
    var interestedUsers : [String] = []
    var postsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("Posts")
    var descriptionLabel: UILabel!
    var refToUsers = FIRDatabase.database().reference().child("Users")
    var refToPost = FIRDatabase.database().reference().child("Posts")
    
   
    static var numberInterested: UIButton!
    var topView = UIView()
    var middleView = UIView()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "turquoise_background")?.draw(in: self.view.bounds)
        
        if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext(){
            UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
        }else{
            UIGraphicsEndImageContext()
            debugPrint("Image not available")
        }
        

        initImageViewUI()
        
        
        topView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/3))
        topView.backgroundColor = UIColor.clear
        
        
        
        
        
        
        
        
        
        
        DetailViewController.currentEvent.getEventPic {
            self.eventView.image = DetailViewController.currentEvent.image
        }
        initDescriptionUI()
        initPosterUI()
        initEventNameUI()
        
        middleView = UIView(frame: CGRect(x: 0, y: topView.frame.maxY, width: view.frame.width, height: view.frame.height/3))
        middleView.backgroundColor = UIColor.clear
        middleView.addSubview(descriptionLabel)
        middleView.addSubview(poster)
        middleView.addSubview(eventName)
        initInterestedButton()
        
        initNumberInterestedUI()
        topView.addSubview(eventView)
        view.addSubview(topView)
        view.addSubview(middleView)
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toInterestedPeople" {
            
            InterestedPeopleViewController.interestedUsers = self.interestedUsers
        }
    }
    
    
    func initImageViewUI() {
        
        eventView = UIImageView(frame: CGRect(x: 0, y: 80, width: self.view.frame.width, height: self.view.frame.height/3))
        eventView.clipsToBounds = true
        eventView.contentMode = UIViewContentMode.scaleAspectFit
        
       
    }
    
    func initEventNameUI() {
        eventName = UILabel(frame: CGRect(x: 10, y: (navigationController?.navigationBar.frame.maxY)! + 20, width: view.frame.width - self.view.frame.width * 0.1, height: 40))
        
        eventName.text = DetailViewController.currentEvent.eventName
        eventName.textColor = UIColor.white
        
    }
    
    func initPosterUI() {
        poster = UILabel(frame: CGRect(x: 10, y: self.view.frame.height * 0.2, width: 100, height: 25))
       
        
        poster.text = DetailViewController.currentEvent.poster
        poster.textColor = UIColor.white
    }
    
    
    func initDescriptionUI() {
        descriptionLabel = UILabel(frame: CGRect(x: 10, y: 150, width: view.frame.width - 10, height: 80))
        descriptionLabel.textColor = UIColor.white
        descriptionLabel.text = DetailViewController.currentEvent.eventDescription
        descriptionLabel.numberOfLines = 5
    }
   
    
    func initInterestedButton() {
        interestedButton = UIButton(frame: CGRect(x: view.frame.width / 2 - 125, y: middleView.frame.maxY + 150, width: 250, height: 35))
        interestedButton.setTitle("Interested?", for: .normal)
        
        interestedButton.backgroundColor = UIColor.init(red:0/255, green:110/255, blue: 110/255, alpha: 1.0)
        interestedButton.addTarget(self, action: #selector(interestedAction), for: .touchUpInside)
        view.addSubview(interestedButton)
    }
    func initNumberInterestedUI() {
        DetailViewController.numberInterested = UIButton(frame: CGRect(x: view.frame.width / 2 - 125, y: middleView.frame.maxY + 100, width: 250, height: 35 ))
        DetailViewController.numberInterested.setTitle(String(describing: DetailViewController.currentEvent.interestedNumber) + " interested", for: .normal)
        DetailViewController.numberInterested.backgroundColor = UIColor.init(red:0/255, green:110/255, blue: 110/255, alpha: 1.0)
        DetailViewController.numberInterested.addTarget(self, action: #selector(displayInterestedPeople), for: .touchUpInside)
        view.addSubview(DetailViewController.numberInterested)
    }
    func displayInterestedPeople() {
        
        performSegue(withIdentifier: "toInterestedPeople", sender: nil)

    }
    func interestedAction() {
        SocialCollectionViewCell.num! += 1
        interestedButton.setTitle("✓ Interested", for: .normal)
        interestedUsers.append(FeedViewController.currentUser.id!)
        DetailViewController.numberInterested.setTitle(String(describing: (DetailViewController.currentEvent.interestedNumber + 1)) + " interested", for: .normal)
        
        //child updates here 
        
        let referenceIntoEvent = postsRef.child(DetailViewController.currentEvent.id!)
        referenceIntoEvent.child("interestedPeople").setValue(interestedUsers)
    
 
    }
}
