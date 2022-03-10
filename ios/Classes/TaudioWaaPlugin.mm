#import "TaudioWaaPlugin.h"

extern int add_c(int a, int b);

@implementation TaudioWaaPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"taudio_waa"
            binaryMessenger:[registrar messenger]];
  TaudioWaaPlugin* instance = [[TaudioWaaPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
        //int x = add_c(1,2);
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
