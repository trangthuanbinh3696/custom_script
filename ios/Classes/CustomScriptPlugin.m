#import "CustomScriptPlugin.h"
#import <custom_script/custom_script-Swift.h>

@implementation CustomScriptPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftCustomScriptPlugin registerWithRegistrar:registrar];
}
@end
