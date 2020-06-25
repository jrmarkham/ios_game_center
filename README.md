# ios_game_center

Flutter wrapper for the iOS Game Center -- GameKit. There is an excellent
 wrapper for Android : https://pub.dev/packages/play_games which is well
  maintained. I designed the API for this plugin to match that plugin.

## Part 1: Sign In 
    final SignInResult _connect = await IOSGameCenter.signIn;
    if ( _connect.success) {
        this.account = result.account;
    } else {
        this.error = result.message;
    }
    this.loading = false;

Note : Sometimes GameCenter will hang and seem to connect, but a connection
 will fail (you get the GameCenter welcome banner,  but the app won't be
  connected). I believe this is an issue more for developers who test on
   their phone's and are switching between account. If this happens then
    close the app. Logout and in of GameCenter directly then try the app again.




This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our 
[online documentation](https://flutter.dev/docs), which offers tutorials, 
samples, guidance on mobile development, and a full API reference.
