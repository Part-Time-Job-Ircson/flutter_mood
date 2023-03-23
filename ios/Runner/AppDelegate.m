#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <BUAdSDK/BUAdSDK.h>
#import <AVFoundation/AVFoundation.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>
#import <AdSupport/ASIdentifierManager.h>
#import <AFNetworking/AFNetworking.h>
@interface AppDelegate ()<BUSplashAdDelegate, BUSplashCardDelegate, BUSplashZoomOutDelegate>

@property (nonatomic, assign) CFTimeInterval startTime;
@property (nonatomic, strong) BUSplashAd *splashAd;

@end

@implementation AppDelegate
-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions {
    BUAdSDKConfiguration *configuration = [BUAdSDKConfiguration configuration];
    configuration.appID = @"5336122";
    [self networkMonitoring];
    return [super application:application willFinishLaunchingWithOptions:launchOptions];
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)networkMonitoring {
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *manger = [AFNetworkReachabilityManager sharedManager];
    //2.开启监听
    [manger startMonitoring];
    //3.监听网络状态的改变
    [manger setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusReachableViaWWAN || AFNetworkReachabilityStatusReachableViaWiFi) {
            [self setupBUAdSDK];
        }
    }];
}

- (void)setupBUAdSDK {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self requestIDFATracking];
    });
    
    [BUAdSDKManager startWithAsyncCompletionHandler:^(BOOL success, NSError *error) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self addSplashAD];
            });
        }
    }];
}

- (void)requestIDFATracking {
    if (@available(iOS 14, *)) {
        // iOS14及以上版本需要先请求权限
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // 获取到权限后，依然使用老方法获取idfa
            if (status == ATTrackingManagerAuthorizationStatusAuthorized) {
                NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
                NSLog(@"%@",idfa);
            } else {
                NSLog(@"请在设置-隐私-跟踪中允许App请求跟踪");
            }
        }];
    } else {
        // iOS14以下版本依然使用老方法
        // 判断在设置-隐私里用户是否打开了广告跟踪
        if ([[ASIdentifierManager sharedManager] isAdvertisingTrackingEnabled]) {
            NSString *idfa = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
            NSLog(@"%@",idfa);
        } else {
            NSLog(@"请在设置-隐私-广告中打开广告跟踪功能");
        }
    }
}

#pragma mark - Splash
- (void)addSplashAD {
    CGRect frame = [UIScreen mainScreen].bounds;
    
    self.startTime = CACurrentMediaTime();
    
    BUSplashAd *splashAd = [[BUSplashAd alloc] initWithSlotID:@"888161429" adSize:frame.size];
    splashAd.supportCardView = YES;
    splashAd.supportZoomOutView = YES;
    splashAd.delegate = self;
    splashAd.cardDelegate = self;
    splashAd.zoomOutDelegate = self;
    splashAd.tolerateTimeout = 3;
    /***
     广告加载成功的时候，会立即渲染WKWebView。
     如果想预加载的话，建议一次最多预加载三个广告，如果超过3个会很大概率导致WKWebview渲染失败。
     */
    self.splashAd = splashAd;
    [self.splashAd loadAdData];
}

- (void)splashAdLoadSuccess:(nonnull BUSplashAd *)splashAd {
    UIWindow *keyWindow = self.window;
    [splashAd showSplashViewInRootViewController:keyWindow.rootViewController];
}

- (void)splashAdLoadFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdRenderFail:(nonnull BUSplashAd *)splashAd error:(BUAdError * _Nullable)error {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashAdRenderSuccess:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdWillShow:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidShow:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdDidClose:(nonnull BUSplashAd *)splashAd closeType:(BUSplashAdCloseType)closeType {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashCardReadyToShow:(nonnull BUSplashAd *)splashAd {
    UIWindow *keyWindow = self.window;
    [splashAd showCardViewInRootViewController:keyWindow.rootViewController];
    
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashCardViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashCardViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashAdViewControllerDidClose:(BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashDidCloseOtherController:(nonnull BUSplashAd *)splashAd interactionType:(BUInteractionType)interactionType {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashVideoAdDidPlayFinish:(nonnull BUSplashAd *)splashAd didFailWithError:(nonnull NSError *)error {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashZoomOutViewDidClick:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}


- (void)splashZoomOutViewDidClose:(nonnull BUSplashAd *)splashAd {
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)splashZoomOutReadyToShow:(nonnull BUSplashAd *)splashAd {
    
    UIWindow *keyWindow = self.window;
    
    // 接入方法一：使用SDK提供动画接入
    if (splashAd.zoomOutView) {
        [splashAd showZoomOutViewInRootViewController:keyWindow.rootViewController];
    }
    [self pbu_logWithSEL:_cmd msg:@""];
}

- (void)pbu_logWithSEL:(SEL)sel msg:(NSString *)msg {
    //    CFTimeInterval endTime = CACurrentMediaTime();
}

@end
