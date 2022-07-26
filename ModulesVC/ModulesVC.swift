//
//  ModulesVC.swift
//  MoculesVC
//
//  Created by Justin Kumpe on 07/26/2022.
//

import UIKit
import CollectionViewCenteredFlowLayout
import Kingfisher
import BadgeSwift
import Haptico
import SwiftMessages

///Modules VC is a collection view controller for displaying module icons on home screen. This can be used as your home page to display icons to each part of your app
open class ModulesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    ///List of Modules
    open var modules: [KModule] = []
    ///Sets Icon Width. Default is 100
    open var iconWidth: Int = 100
    ///Sets cell background color. Default is clear
    open var cellBackgroundColor: UIColor = .clear
    ///Sets collectionView background color. Default is clear
    open var collectionViewBackgroundColor: UIColor = .clear
    ///Sets icon cache
    public let iconCache = ImageCache(name: "iconCache")

    ///collectionView used for module icons
    open var collectionView: UICollectionView = {
        var layout = UICollectionViewLayout()
        var cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ModuleCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()

    ///Adds collectionView to subView and sets constraints
    public func setupCollectionView() {
        view.addSubview(collectionView)
        setCollectionViewConstraints()
        collectionView.delegate = self
        collectionView.dataSource = self
        let layout = CollectionViewCenteredFlowLayout()
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = collectionViewBackgroundColor
        reloadCollectionView()
        setIconCacheExpiration()
    }

    ///Sets expiration of iconCache for remote icons that have been fetched. Defaults to 90days
    open func setIconCacheExpiration() {
        iconCache.diskStorage.config.expiration = .days(90)
        iconCache.memoryStorage.config.expiration = .days(90)
    }

    ///Sets constraints for collectionView
    open func setCollectionViewConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    ///Calls collectionView.reload on main. You can override this if you need to pull data or other functions before reloading the collectionView. You will want to input your code BEFORE calling super.reloadCollectionView
    open func reloadCollectionView() {
            self.collectionView.reloadData()
    }

    ///Centers module icons in collection view
    open func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
        let totalWidth = cellWidth * numberOfItems
        let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
        let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }

    ///Set Number of Items. Defaults to modules.count
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modules.count
    }

    ///Set Cell Size
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = iconWidth
        return CGSize(width: screenWidth, height: screenWidth)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let module = modules[(indexPath as NSIndexPath).row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ModuleCollectionViewCell
        cell.watermark.isHidden = true
        cell.badge.isHidden = true
        if module.badgeText != nil {
            cell.badge.text = module.badgeText!
            cell.badge.badgeColor = module.settings.badge.badgeColor
            cell.badge.borderColor = module.settings.badge.borderColor
            cell.badge.cornerRadius = module.settings.badge.cornerRadius
            cell.badge.borderWidth = module.settings.badge.borderWidth
            cell.badge.textColor = module.settings.badge.textColor
            cell.badge.font = module.settings.badge.font
            cell.badge.isHidden = false
        }
        cell.imageView.image = module.icon
        if module.remoteIconUrl != nil {
            cell.imageView.kf.setImage(
                with: URL(string: module.remoteIconUrl!),
                placeholder: module.icon,
                options: [
                    .transition(.fade(1)),
                    .cacheOriginalImage,
                    .cacheSerializer(FormatIndicatedCacheSerializer.png),
                    .targetCache(iconCache)
                    ])
        }
        cell.title.text = module.title
        cell.title.textColor = module.settings.title.textColor
        cell.title.isHidden = module.settings.title.isHidden
        cell.title.textAlignment = module.settings.title.textAlignment
        cell.title.font = module.settings.title.font
        if !module.isEnabled && module.watermark != nil {
            cell.watermark.image = module.watermark!
            cell.watermark.isHidden = false
         }
        cell.backgroundColor = cellBackgroundColor
        return cell
    }

    ///collectionView didSelectItemAt by default calls function didSelectModule(module)
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let module = modules[(indexPath as NSIndexPath).row]
        didSelectModule(module)
    }

    ///didSelectModule is called by default when a collectionView cell is tapped. By default this method will display Access Denied message if module isEnabled=false or perform segue withIdentifier module.action if module.action contains "segue"
    open func didSelectModule(_ module: KModule) {
        guard module.isEnabled else {
            ShowAlert.centerView(theme: .error, title: "Access Denied", message: "You do not have access to \(module.title).", seconds: .infinity, invokeHaptics: true)
            return
        }
        if module.action.contains("segue") {
            performSegue(withIdentifier: module.action, sender: self)
        }
    }

    ///Returns KModule using given parameters and settiings. This is useful if you need custom badge or title settings that you need applied to multiple modules. Create variables for your settings and pass them to this one function instead of having to set the settings on each module individually.
    public func buildModule(title: String, action: String, icon: UIImage, remoteIconURL: String? = nil, badgeText: String? = nil, isEnabled: Bool = true, watermark: UIImage? = nil, badgeSettings: KModuleSettingsBadge = KModuleSettingsBadge(), titleSettings: KModuleSettingsTitle = KModuleSettingsTitle(), watermarkSettings: KModuleSettingsWatermark = KModuleSettingsWatermark()) -> KModule {
        var settingsBundle: KModuleSettings = KModuleSettings()
        settingsBundle.badge = badgeSettings
        settingsBundle.title = titleSettings
        var module: KModule = KModule(title: title, action: action, icon: icon, remoteIconURL: remoteIconURL, badgeText: badgeText, watermark: watermark, isEnabled: isEnabled)
        module.settings = settingsBundle
        return module
    }

}
