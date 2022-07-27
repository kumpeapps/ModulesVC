# ModulesVC

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/d17767442e034c0aa98e580f7822c9c8)](https://app.codacy.com/gh/kumpeapps/ModulesVC?utm_source=github.com&utm_medium=referral&utm_content=kumpeapps/ModulesVC&utm_campaign=Badge_Grade_Settings) <img src="https://img.shields.io/cocoapods/v/ModulesVC"/> <img src="https://img.shields.io/github/last-commit/kumpeapps/ModulesVC"/>

ModulesVC is a collection view controller used for modules/sections selection. I used it as my home screen for users to click module icons to goto specific areas within my app.

---

## Installation
Using CocoaPods

`pod 'ModulesVC'`

## Setup
- Create a new view and view controller
- import ModulesVC
- Conform your view controller to ModulesVC
- Configure your modules (see below)
- Call setupCollectionView()

## Third Party Frameworks Used
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [BadgeSwift](https://github.com/evgenyneu/swift-badge)
- [Haptico](https://github.com/iSapozhnik/Haptico)
- [SwiftMessages](https://github.com/SwiftKickMobile/SwiftMessages)
- [CollectionViewCenteredFlowLayout](https://github.com/Coeur/CollectionViewCenteredFlowLayout)
- [DeviceKit](https://github.com/devicekit/DeviceKit)

## Configuring Modules

### Default Module
```swift
let module1 = KModule.init(title: "Users", action: "segueUsers", icon: UIImage(named: "icons8-swirl")!)
let module2 = KModule.init(title: "Cable Count Calculator", action: "test", icon: UIImage(named: "icons8-swirl")!, remoteIconURL: "https://img.icons8.com/external-flaticons-flat-flat-icons/64/000000/external-test-nursing-flaticons-flat-flat-icons.png", badgeText: "New", isEnabled: false, watermark: UIImage(named: "icons8-disabled"))
modules = [module2,module2]
```
- Title is displayed as a UILabel at the bottom of the module icon.
- Action is used to call didSelectModule function when module icon is tapped. By default if the module's isEnabled is set to false then an access denied alert will be displayed, otherwise if the word segue is in the action then it will perform segue on the action text. Ex. action "segueUsers" will perform segue on "segueUsers".
- Icon is the icon to display for the module
- badgeText is optional and if not nil will display a badge in the upper right of the module icon with the badgeText
- isEnabled sets the module to enabled for the user
- watermark is optional and used to set an image as a watermark over the top of the module icon if module isEnabled=false

### Custom Module
Module text and badge can be customized by passing "settings bundles". The easiest way to do this is by using the buildModule() function.
```swift
        var settingsBundle: KModuleSettings = KModuleSettings()
        settingsBundle.badge.badgeColor = .gray
        settingsBundle.badge.textColor = .white
        settingsBundle.title.textColor = .brown
        settingsBundle.title.font = UIFont(name: "Marker Felt", size: 17)!
        settingsBundle.watermark.alpha = 0.85
        
        var module3 = buildModule(title: "Users", action: "segueUsers", icon: UIImage(named: "icons8-swirl")!, remoteIconURL: "https://img.icons8.com/external-flaticons-flat-flat-icons/64/000000/external-test-nursing-flaticons-flat-flat-icons.png", badgeText: "New", isEnabled: false, watermark: UIImage(named: "icons8-disabled"), badgeSettings: settingsBundle.badge, titleSettings: settingsBundle.title, watermarkSettings: settingsBundle.watermark)
        modules = [module3]
```
## Customize

### Customize Default Settings

```swift
    ///Sets Icon Width. Default is 100
    iconWidth = 100
    ///Sets cell background color. Default is clear
    cellBackgroundColor = .clear
    ///Sets collectionView background color. Default is clear
    collectionViewBackgroundColor = .clear
    ///Sets the title of the alert displayed when user clicks on disabled module
    disabledAlertTitle = "Access Denied"
    ///Sets the message of the alert displayed when user clicks on disabled module
    disabledAlertMessage = "You do not have access to this module!"
```

### Remote Icon Cache
By default remote icons are downloaded and saved in cache for 90 days. Once the cache has expired the icon will be re-downloaded next time it is used. This can be changed by overriding setIconImageCachExpiration()

```swift
override func setIconCacheExpiration() {
        iconCache.diskStorage.config.expiration = .days(90)
        iconCache.memoryStorage.config.expiration = .days(90)
    }
```

### Collection View Constraints
By default collection view constraints are set to view bounds. This can be changed by overriding setCollectionViewConstraints()

```swift
override func setCollectionViewConstraints() {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
```

### Reload Collection View
If you need code to be called each time the collection view is reloaded you can override reloadCollectionView()

```swift
override func reloadCollectionView() {
            self.collectionView.reloadData()
    }
```

### Did Select Module
You can override the function didSelectModule() to customize actions when user taps on module icon.

```swift
override func didSelectModule(_ module: KModule) {
        guard module.isEnabled else {
            ShowAlert.centerView(theme: .error, title: self.disabledAlertTitle, message: self.disabledAlertMessage, seconds: .infinity, invokeHaptics: true)
            return
        }
        if module.action.contains("segue") {
            performSegue(withIdentifier: module.action, sender: self)
        }
    }
 ```