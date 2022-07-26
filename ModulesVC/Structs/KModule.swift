//
//  KModule.swift
//  ModulesVC
//
//  Created by Justin Kumpe on 7/26/22.
//

import UIKit

///Defines a module
public struct KModule {
    public var title: String
    public var action: String
    public var icon: UIImage
    public var remoteIconUrl: String?
    public var badgeText: String?
    public var isEnabled: Bool
    public var watermark: UIImage?
    public var settings: KModuleSettings
    public init(title: String, action: String, icon: UIImage, remoteIconURL: String? = nil, badgeText: String? = nil, watermark: UIImage? = nil, isEnabled: Bool = true) {
        self.title = title
        self.action = action
        self.icon = icon
        self.remoteIconUrl = remoteIconURL
        self.badgeText = badgeText
        self.isEnabled = isEnabled
        self.watermark = watermark
        self.settings = KModuleSettings()
    }
}
