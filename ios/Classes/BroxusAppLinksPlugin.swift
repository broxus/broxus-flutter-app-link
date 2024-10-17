import Flutter
import UIKit

public class BroxusAppLinksPlugin: NSObject, FlutterPlugin, FlutterApplicationLifeCycleDelegate {
    
    private static let METHOD_CHANNEL = "broxus_app_links/methods"
    private var methodChannel: FlutterMethodChannel?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = BroxusAppLinksPlugin()
        instance.methodChannel = FlutterMethodChannel(name: METHOD_CHANNEL, binaryMessenger: registrar.messenger())
        registrar.addMethodCallDelegate(instance, channel: instance.methodChannel!)
        
        registrar.addApplicationDelegate(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([Any]) -> Void
    ) -> Bool {
        
        switch userActivity.activityType {
            case NSUserActivityTypeBrowsingWeb:
                if let url = userActivity.webpageURL {
                    dispatchUri(url)
                }
                return false
            default: return false
        }
    }
    
    private func dispatchUri(_ uri: URL) {
        do {
            DispatchQueue.main.async {
                self.methodChannel?.invokeMethod("newUri", arguments: [
                    "uriStr": uri.absoluteString
                ])
            }
        } catch {
            print("Error dispatching URI: \(error.localizedDescription)")
        }
    }
}
