//
//  FollowedUserCollectionViewCell.swift
//  GuideProject_Habits
//
//  Created by Tomonao Hashiguchi on 2022-06-02.
//

import UIKit

class FollowedUserCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var primaryTextLabel: UILabel!
    @IBOutlet var secondaryTextLabel: UILabel!
    @IBOutlet var separatorLineView: UIView!
    @IBOutlet var separatorLineheightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        separatorLineheightConstraint.constant = 1 / UITraitCollection.current.displayScale
    }
}
