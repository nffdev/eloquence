import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    private struct ChannelNames {
        static let iconManager = "com.eloquence.icon_manager"
    }
    
    private struct MethodNames {
        static let supportsAlternateIcons = "supportsAlternateIcons"
        static let getCurrentIcon = "getCurrentIcon"
        static let setIcon = "setIcon"
        static let setLightIcon = "setLightIcon"
        static let setDarkIcon = "setDarkIcon"
        static let setDefaultIcon = "setDefaultIcon"
        static let toggleIcon = "toggleIcon"
        static let setIconForAppearance = "setIconForAppearance"
        static let getAvailableIcons = "getAvailableIcons"
    }
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        GeneratedPluginRegistrant.register(with: self)
        
        setupIconManagerChannel()
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // MARK: - Private Methods
    
    private func setupIconManagerChannel() {
        guard let controller = window?.rootViewController as? FlutterViewController else {
            return
        }
        
        let channel = FlutterMethodChannel(
            name: ChannelNames.iconManager,
            binaryMessenger: controller.binaryMessenger
        )
        
        channel.setMethodCallHandler { [weak self] (call, result) in
            self?.handleIconManagerMethodCall(call: call, result: result)
        }
    }
    
    private func handleIconManagerMethodCall(
        call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        let iconManager = IconManager.shared
        
        switch call.method {
        case MethodNames.supportsAlternateIcons:
            result(iconManager.supportsAlternateIcons())
            
        case MethodNames.getCurrentIcon:
            result(iconManager.currentIconName)
            
        case MethodNames.getAvailableIcons:
            result(iconManager.availableIcons)
            
        case MethodNames.setIcon:
            handleSetIcon(call: call, result: result)
            
        case MethodNames.setLightIcon:
            iconManager.setLightIcon { success, error in
                self.handleIconChangeResult(success: success, error: error, result: result)
            }
            
        case MethodNames.setDarkIcon:
            iconManager.setDarkIcon { success, error in
                self.handleIconChangeResult(success: success, error: error, result: result)
            }
            
        case MethodNames.setDefaultIcon:
            iconManager.setDefaultIcon { success, error in
                self.handleIconChangeResult(success: success, error: error, result: result)
            }
            
        case MethodNames.toggleIcon:
            iconManager.toggleIcon { success, error in
                self.handleIconChangeResult(success: success, error: error, result: result)
            }
            
        case MethodNames.setIconForAppearance:
            iconManager.setIconForCurrentAppearance { success, error in
                self.handleIconChangeResult(success: success, error: error, result: result)
            }
            
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    private func handleSetIcon(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let arguments = call.arguments as? [String: Any],
              let iconName = arguments["iconName"] as? String else {
            result(FlutterError(
                code: "INVALID_ARGUMENTS",
                message: "Icon name is required",
                details: nil
            ))
            return
        }
        
        let iconManager = IconManager.shared
        let finalIconName = iconName.isEmpty ? nil : iconName
        
        iconManager.setAlternateIcon(iconName: finalIconName) { success, error in
            self.handleIconChangeResult(success: success, error: error, result: result)
        }
    }
    
    private func handleIconChangeResult(
        success: Bool,
        error: String?,
        result: @escaping FlutterResult
    ) {
        if success {
            result([
                "success": true,
                "currentIcon": IconManager.shared.currentIconName
            ])
        } else {
            result(FlutterError(
                code: "ICON_CHANGE_FAILED",
                message: error ?? "Error changing icon",
                details: nil
            ))
        }
    }
}
