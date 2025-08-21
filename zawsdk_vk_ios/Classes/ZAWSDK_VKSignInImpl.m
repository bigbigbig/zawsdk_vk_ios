//
//  ZAWVK.m
//  ZAWSDKIOS
//
//  Created by zhangmingsheng on 2025/8/16.
//

#import "ZAWSDK_VKSignInImpl.h"
#import "zawsdk_vk_ios/zawsdk_vk_ios-Swift.h"
@interface ZAWSDK_VKSignInImpl ()
@property(nonatomic, strong) ZAWSDKVK *vk;
@property(nonatomic, strong) UIViewController *presentingViewController;
@property(nonatomic, copy) void (^sucess)(NSString *idToken, NSString *tid, NSString *tname);
@property(nonatomic, copy) void (^failure)(NSInteger code, NSString *message);
@end

@implementation ZAWSDK_VKSignInImpl

+ (instancetype)sharedInstance
{
    static ZAWSDK_VKSignInImpl* _instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (instancetype)init{
    self = [super init];
    self.vk = [ZAWSDKVK new];
    if (!self) {
        return nil;
    }
    return self;
}

- (void)configWithClientId:(NSString *)clientId clientSecret:(NSString *)clientSecret{
    [self.vk configWithClientId:clientId clientSecret:clientSecret];
}

- (BOOL)open:(NSURL *)url{
    return [self.vk openWithUrl:url];
}

- (void)signInWithPresentingViewController:(UIViewController *)presentingViewController
                                   success:(nonnull void (^)(NSString *idToken, NSString *tid, NSString *tname))sucess
                                   failure:(nonnull void (^)(NSInteger code, NSString *message))failure{
    
    self.presentingViewController = presentingViewController;
    __weak typeof(self) weakSelf = self;
    self.sucess = ^(NSString *userIdToken, NSString *tid, NSString *tname){
        sucess(userIdToken, tid, tname);
        weakSelf.presentingViewController = nil;
    };
    self.failure = ^(NSInteger code, NSString *message) {
        failure(code, message);
        weakSelf.presentingViewController = nil;
    };
    [self requestAuth:presentingViewController];
}

- (void)requestAuth:(UIViewController *)presentingViewController {
    [self.vk authorizeWithViewController:presentingViewController completion:^(BOOL sucess, NSString * _Nullable idToken, NSString * _Nullable tid,  NSString * _Nullable tname, NSError * _Nullable error) {
        if (sucess) {
            if (self.sucess != nil) {
                self.sucess(idToken, tid, tname);
            }
        }else {
            if (self.failure != nil) {
                self.failure(error.code, error.userInfo.description);
            }
        }
    }];
}
@end
