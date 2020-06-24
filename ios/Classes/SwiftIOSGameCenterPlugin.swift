import Flutter
import UIKit
import GameKit

public class SwiftIOSGameCenterPlugin: NSObject, FlutterPlugin {
// view controller
  var viewController: UIViewController {
    return UIApplication.shared.keyWindow!.rootViewController!
  }



func signInUser(result: @escaping FlutterResult) {
     let player = GKLocalPlayer.local
    player.authenticateHandler = { vc, error in
      guard error == nil else {
      let error:[String: Any] = ["type" : "FAILURE", "message":"NIL error in iOS", "success":false, "account":""]
       result(error)
        return
      }
      if let vc = vc {
        self.viewController.present(vc, animated: true, completion: nil)
      } else if player.isAuthenticated {

        var playerID:String
        if #available(iOS 12.4, *){
            playerID = player.gamePlayerID
         }else{
            playerID = player.playerID
         }

         let results:[String: Any] = ["type" :"SUCCESS", "success":true,
         "message":"player connect to game center", "account" :["id":playerID, "displayName": player.displayName,"email":""]]

        result(results)
      } else {
         let error:[String: Any] = ["type" : "FAILURE", "message":"player auth failed", "success":false,"account":""]
        result(error)
      }
    }
  }




  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     //let arguments = call.arguments as? [String: Any]
        switch call.method {
            case "getSignIn":signInUser(result:result)
    default:
      result("unimplemented")
      break
    }
  }


   public static func register(with registrar: FlutterPluginRegistrar) {
       let channel = FlutterMethodChannel(name: "plugin.markhamenterprises.com/ios_game_center", binaryMessenger: registrar.messenger())
       let instance = SwiftIOSGameCenterPlugin()
       registrar.addMethodCallDelegate(instance, channel: channel)
     }
}


extension SwiftIOSGameCenterPlugin: GKGameCenterControllerDelegate {
  public func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
    viewController.dismiss(animated: true, completion: nil)
  }
}