//
//  AppDelegate.swift
//  iOSIntegrationFlutterModule
//
//  Created by PhuongMT on 05/07/2022.
//

import UIKit
import Flutter

@UIApplicationMain
class AppDelegate: FlutterAppDelegate { // More on the FlutterAppDelegate.
  lazy var flutterEngine = FlutterEngine(name: "phuongmt_flutter_module")

    fileprivate func configChannel() {
//        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController =
        FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        
        let  channel = "SenpayTest"
        let methodChannel = FlutterMethodChannel(name: channel, binaryMessenger: flutterViewController.binaryMessenger)
        methodChannel.setMethodCallHandler({
            (call, result) in
            if (call.method == "getDataFromNative") {
                result("Hello PhuongMT")
            } else if (call.method == "sendDataToNative") {
                print("phuongmt: native \(String(describing: call.arguments))")
                result("Hello PhuongMT 222")
            }
        })
    }
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Runs the default Dart entrypoint with a default Flutter route.
  
    flutterEngine.run();
      
    configChannel()
    // Used to connect plugins (only if you have plugins with iOS platform code).
    return super.application(application, didFinishLaunchingWithOptions: launchOptions);
  }
}


