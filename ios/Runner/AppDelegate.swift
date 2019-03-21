import UIKit
import Flutter
// Add the GoogleMaps import.
import GoogleMaps


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    // Add the following line with your API key.
    GMSServices.provideAPIKey("AIzaSyDl9QeRAuxWbotsahlW8hHFUB1zjhS879Y")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
