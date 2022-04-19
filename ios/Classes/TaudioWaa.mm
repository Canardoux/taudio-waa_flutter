#import "TaudioWaa.h"
#import "../../../taudio-waa_native/rust/target/bindings.h"


@implementation TaudioWaa
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"taudio_waa"
            binaryMessenger:[registrar messenger]];
  TaudioWaa* instance = [[TaudioWaa alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

// ...
//- (void) dummyMethodToEnforceBundling {
    // This will never be executed
    ///rust_greeting("");
  //}

@end
