//
//  KModuleSettings.swift
//  ModulesVC
//
//  Created by Justin Kumpe on 7/26/22.
//

import Foundation
import UIKit
import SwiftMessages

///Defines a custom Badge settings bundle
public struct KModuleSettingsBadge {
    public var badgeColor: UIColor = .red
    public var borderColor: UIColor = .red
    public var cornerRadius: CGFloat = -1
    public var borderWidth: CGFloat = 0
    public var textColor: UIColor = .white
    public var font: UIFont = UIFont(name: "Helvetica", size: 14)!
    public var isHidden: Bool = false
    public init () {}
}

///Defines a custom Title settings bundle
public struct KModuleSettingsTitle {
    public var textColor: UIColor = .white
    public var isHidden: Bool = false
    public var textAlignment: NSTextAlignment = .center
    public var font: UIFont = UIFont(name: "Marker Felt", size: 17)!
    public init () {}
}

///Defines a custom Watermark settings bundle
public struct KModuleSettingsWatermark {
    public var alpha: CGFloat = 0.85
    public var isHidden: Bool = true
    public init() {}
}

///Defines a custom settings bundle
public struct KModuleSettings {
    public var badge: KModuleSettingsBadge = KModuleSettingsBadge()
    public var title: KModuleSettingsTitle = KModuleSettingsTitle()
    public var watermark: KModuleSettingsWatermark = KModuleSettingsWatermark()
    public var alert: KModuleSettingsDisabledAlert = KModuleSettingsDisabledAlert()
    public init() {}
}

//Defines a custom DisabledAlert settings bundle
public struct KModuleSettingsDisabledAlert {
    public var theme: Theme = .error
    public var title: String = "Access Denied"
    public var message: String = "You do not have access to this module!"
    public var seconds: Double  = .infinity
    public init() {}
}
