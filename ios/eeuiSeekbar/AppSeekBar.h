//
//  AppSeekBar.h
//  AFNetworking
//
//

#import <UIKit/UIKit.h>
#import <WeexSDK/WeexSDK.h>
#import <WeexSDK/WXResourceLoader.h>
#import <WeexPluginLoader/WeexPluginLoader.h>
 

@interface AppSeekBar : WXComponent
@property (nonatomic,strong)NSString *color;
@property (nonatomic)float progress;
@property (nonatomic)float min;
@property (nonatomic)float max;
@end


