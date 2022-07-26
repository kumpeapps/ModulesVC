//
//  ModuleCollectionViewCell.swift
//  ModulesVC
//
//  Created by Justin Kumpe on 07/26/2022.
//  Copyright © 2022 Justin Kumpe. All rights reserved.
//

import UIKit
import BadgeSwift

open class ModuleCollectionViewCell: UICollectionViewCell {

    ///imageView is used to display the module icon
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    ///watermark is placed over the top of the icon when the moule isEnabled = false. watermark alpha is set to 0.85 by default
    let watermark: UIImageView = {
        let watermark = UIImageView()
        watermark.translatesAutoresizingMaskIntoConstraints = false
        watermark.contentMode = .scaleAspectFit
        return watermark
    }()
    ///title to be displayed below the module icon
    let title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.textAlignment = .center
        title.adjustsFontSizeToFitWidth = true
        return title
    }()
    ///badge to be displayed in upper right corner of module icon
    let badge: BadgeSwift = {
        let badge = BadgeSwift()
        badge.translatesAutoresizingMaskIntoConstraints = false
        badge.badgeColor = .red
        badge.textColor = .white
        return badge
    }()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        contentView.addSubview(badge)
        contentView.addSubview(watermark)
        imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.8).isActive = true
        imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        title.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        title.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        badge.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor).isActive = true
        badge.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        badge.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        watermark.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        watermark.bottomAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        watermark.leadingAnchor.constraint(equalTo: imageView.leadingAnchor).isActive = true
        watermark.trailingAnchor.constraint(equalTo: imageView.trailingAnchor).isActive = true
        watermark.alpha = 0.7
        watermark.isHidden = true
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

}
