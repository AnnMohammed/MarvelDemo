//
//  RoundCornerViewViewController.swift
//  Layalina
//
//  Created by Mac on 3/20/20.
//  Copyright © 2020 khaled omar. All rights reserved.
//

import UIKit

class view: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
}

class viewWithThirty: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 30
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
}
class stackView: UIStackView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 30
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
}
class imageViewThirty: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 30
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
}

class button : UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner]
    }
}
