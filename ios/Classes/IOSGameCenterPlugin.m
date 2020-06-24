#import "IOSGameCenterPlugin.h"
#if __has_include(<ios_game_center/ios_game_center-Swift.h>)
#import <ios_game_center/ios_game_center-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ios_game_center-Swift.h"
#endif

@implementation IOSGameCenterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIOSGameCenterPlugin registerWithRegistrar:registrar];
}
@end
