import UIKit
import Foundation

@objc public class IconManager: NSObject {
    
    // MARK: - Singleton
    @objc public static let shared = IconManager()
    
    // MARK: - Constants
    private struct IconNames {
        static let light = "AppIcon-Light"
        static let dark = "AppIcon-Dark"
        static let `default` = "AppIcon" 
    }
    
    // MARK: - Public Properties
    
    @objc public var availableIcons: [String] {
        return [IconNames.light, IconNames.dark]
    }
    
    @objc public var currentIconName: String {
        return UIApplication.shared.alternateIconName ?? IconNames.default
    }
    
    @objc public var currentAlternateIconName: String? {
        return UIApplication.shared.alternateIconName
    }
    
    // MARK: - Initialization
    private override init() {
        super.init()
    }
    
    // MARK: - Public Methods
    
    @objc public func supportsAlternateIcons() -> Bool {
        return UIApplication.shared.supportsAlternateIcons
    }
    
    @objc public func setAlternateIcon(
        iconName: String?,
        completion: @escaping (Bool, String?) -> Void
    ) {
        guard supportsAlternateIcons() else {
            completion(false, "Error : Alternate icons are not supported")
            return
        }
        
        if let iconName = iconName, !availableIcons.contains(iconName) {
            completion(false, "Icon '\(iconName)' not available. Availables icons: \(availableIcons.joined(separator: ", "))")
            return
        }
        
        if currentIconName == (iconName ?? IconNames.default) {
            completion(true, nil)
            return
        }
        
        UIApplication.shared.setAlternateIconName(iconName) { error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(false, "Error while updating icon: \(error.localizedDescription)")
                } else {
                    completion(true, nil)
                }
            }
        }
    }
    
    @objc public func setLightIcon(completion: @escaping (Bool, String?) -> Void) {
        setAlternateIcon(iconName: IconNames.light, completion: completion)
    }
    
    @objc public func setDarkIcon(completion: @escaping (Bool, String?) -> Void) {
        setAlternateIcon(iconName: IconNames.dark, completion: completion)
    }
    
    @objc public func setDefaultIcon(completion: @escaping (Bool, String?) -> Void) {
        setAlternateIcon(iconName: nil, completion: completion)
    }
    
    @objc public func setIconForCurrentAppearance(completion: @escaping (Bool, String?) -> Void) {
        var isDarkMode = false
        if #available(iOS 13.0, *) {
            isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark
        }
        let targetIcon = isDarkMode ? IconNames.dark : IconNames.light
        setAlternateIcon(iconName: targetIcon, completion: completion)
    }
    
    @objc public func toggleIcon(completion: @escaping (Bool, String?) -> Void) {
        let currentAlternate = currentAlternateIconName
        let newIcon: String
        
        if currentAlternate == IconNames.light {
            newIcon = IconNames.dark
        } else if currentAlternate == IconNames.dark {
            newIcon = IconNames.light
        } else {
            newIcon = IconNames.light
        }
        
        setAlternateIcon(iconName: newIcon, completion: completion)
    }
}

extension IconManager {
    
    @objc public enum IconType: Int, CaseIterable {
        case light = 0
        case dark = 1
        
        var iconName: String {
            switch self {
            case .light: return IconNames.light
            case .dark: return IconNames.dark
            }
        }
        
        var displayName: String {
            switch self {
            case .light: return "Clair"
            case .dark: return "Sombre"
            }
        }
    }
    
    @objc public func setIcon(
        type iconType: IconType,
        completion: @escaping (Bool, String?) -> Void
    ) {
        setAlternateIcon(iconName: iconType.iconName, completion: completion)
    }
    
    @objc public var currentIconType: IconType {
        return currentIconName == IconNames.light ? .light : .dark
    }
}