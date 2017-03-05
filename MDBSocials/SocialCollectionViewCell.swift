//
//  SocialCollectionViewCell.swift
//  MDBSocials
//
//  Created by Amy on 2/21/17.
//  Copyright © 2017 Amy. All rights reserved.
//

import UIKit

class SocialCollectionViewCell: UICollectionViewCell {
    var eventImage: UIImageView!
    var posterText: UILabel!
    var eventNameText: UITextView!
    var likeButton: UIButton!
    static var num: Int!
    override func awakeFromNib() {
        super.awakeFromNib()
        SocialCollectionViewCell.num = 0
        self.backgroundColor = UIColor.clear
        setupEventImage()
        setupPosterText()
        setupPostText()
        setupLikeButton()
    }
    
    func setupEventImage() {
        eventImage = UIImageView(frame: CGRect(x: 10, y: 10, width: 0.50 * self.frame.height, height: 0.8 * self.frame.height))
        eventImage.clipsToBounds = true
        eventImage.contentMode = .scaleAspectFit
        addSubview(eventImage)
    }
    
    func setupPosterText() {
        posterText = UILabel(frame: CGRect(x: 10, y: 120, width: self.frame.width, height: 50))
        posterText.textColor = UIColor.white
        
        posterText.adjustsFontForContentSizeCategory = true
        addSubview(posterText)
    }
    
    func setupPostText() {
        eventNameText = UITextView(frame: CGRect(x: eventImage.frame.maxX + 8, y: posterText.frame.maxY - 110 , width: self.frame.width, height: 60))
        eventNameText.textColor = UIColor.white
        eventNameText.backgroundColor = UIColor.clear
        eventNameText.adjustsFontForContentSizeCategory = true
        eventNameText.font = UIFont.systemFont(ofSize: 24, weight: 2)
        
        eventNameText.isEditable = false
        addSubview(eventNameText)
        
    }
    func setupLikeButton() {
        likeButton = UIButton(frame: CGRect(x: 10, y: eventImage.frame.maxY, width: 100, height: 30))
        likeButton.setTitle((String(SocialCollectionViewCell.num) + " interested"), for: .normal)
        likeButton.setTitle("Uninterested", for: .selected)
        likeButton.setTitleColor(UIColor.white, for: .normal)
        addSubview(likeButton)
    }
    
}
