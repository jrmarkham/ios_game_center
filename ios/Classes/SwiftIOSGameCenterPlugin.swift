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
      let error:[String: Any] = ["response" : "failure", "message":"NIL error"]
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

         let results:[String: Any] = ["response" :"success","message":"player connect to game center", "id":playerID,
         "displayName": player.displayName,"email":""]

        result(results)
      } else {
         let error:[String: Any] = ["response" : "failure", "message":"player auth failed"]
        result(error)
      }
    }
  }

func showLeaderboard(id: String, result: @escaping FlutterResult) {
    let vc = GKGameCenterViewController()
    vc.gameCenterDelegate = self
    vc.viewState = .achievements
    vc.leaderboardIdentifier = id
    viewController.present(vc, animated: true, completion: nil)
    result("success")
  }

  func submitScore(score: Int64, id: String, result:@escaping FlutterResult) {
    let reportedScore = GKScore(leaderboardIdentifier: id)
    reportedScore.value = score
    GKScore.report([reportedScore]) { (error) in
      guard error == nil else {
        result(error?.localizedDescription ?? "")
        return
      }
      result("success")
    }
  }


  func showAchievements(result: @escaping FlutterResult) {
    let vc = GKGameCenterViewController()
    vc.gameCenterDelegate = self
    vc.viewState = .achievements
    viewController.present(vc, animated: true, completion: nil)
    result("success")
  }

// UNLOCK
func unlockAchievement(id: String, result: @escaping FlutterResult) {
    let achievement = GKAchievement(identifier: id)
    achievement.percentComplete = 100
    achievement.showsCompletionBanner = true
    GKAchievement.report([achievement]) { (error) in
      guard error == nil else {
        result(error?.localizedDescription ?? "")
        return
      }
      result("success")
    }
  }

// INCREMENT
  func incrementAchievement(id: String, increment: Double,
  result: @escaping FlutterResult) {
    let achievement = GKAchievement(identifier: id)
    achievement.percentComplete = increment
    achievement.showsCompletionBanner = true
    GKAchievement.report([achievement]) { (error) in
      guard error == nil else {
        result(error?.localizedDescription ?? "")
        return
      }
      result("success")
    }
  }



  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
     let arguments = call.arguments as? [String: Any]
        switch call.method {
            case "getSignIn" ->signInUser(result:result)
            case "showLeaderboard" ->{
                val id = call.argument<String>("id") as String
                showLeaderboard(id,result)
            }
            case "submitScore"->{
                val id = call.argument<String>("id") as String
                val score = call.argument<Int64>("score") as Int64
                submitScore(leaderboardID,result:result )
            }
            case "showAchievements"->showAchievements(result:result)
            case "unlockAchievement"->{
                val id = call.argument<String>("id") as String
                unlockAchievement(achievementID, result)
            }
            case "incrementAchievement"->{
                val id = call.argument<String>("id") as String
                val increment = call.argument<Double>("increment") as Double
                incrementAchievement(achievementID, percentComplete, result)
            }
            default->{
                result("unimplemented")
                break
            }
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
