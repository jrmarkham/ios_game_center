# ios_game_center

Flutter wrapper for the iOS Game Center -- GameKit. There is an excellent wrapper for Android : https://pub.dev/packages/play_games which is well maintained. I designed the API for this plugin to resemble the API of that plugin.

## Part 1: Sign In 
    final SignInResult _connect = await IOSGameCenter.signIn;
    if ( _connect.success) {
        this.account = result.account;
    } else {
        this.error = result.message;
    }
    this.loading = false;

Note : Sometimes GameCenter will hang and seem to connect, but a connection will fail (you get the GameCenter welcome banner,  but the app won't be connected). I believe this is an issue more for developers who test on their phone's and are switching between account. If this happens then close the app. Logout and in of GameCenter directly then try the app again.
    
    
The Game Center Sign In will prompt on any app, but to actually connect you
 should add the GameCenter Service to your app via xCode.

![](_image/gamecenter_01.jpg)
    
    
Score Functions. You'll need to go to the App Store Connect (https://appstoreconnect.apple.com), Then select your app, then select Features, then Game Center, and there you add
  achievements and leaderboards.

![](_image/gamecenter_02.jpg)

 
 

  

## Part 2: Leaderboard
Show leaderboard


    final SignInResult _connect = await IOSGameCenter.signIn;
    

this.loading = false;




IOSGameCenter.showLeaderboard(LB_IOS_VICTORY)

    final SignInResult _connect = await IOSGameCenter.signIn;
    



## Part 2: Achievements 
Show Archievements:

    final SignInResult _connect = await IOSGameCenter.signIn;

Post Achievements:




    final SignInResult _connect = await IOSGameCenter.signIn;
    


    final SignInResult _connect = await IOSGameCenter.signIn;
    


