//
//  ZAWVK.h
//  ZAWSDKIOS
//
//  Created by zhangmingsheng on 2025/8/16.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface ZAWSDK_VKSignInImpl : NSObject

+ (instancetype)sharedInstance;
- (void)configWithClientId:(NSString *)clientId clientSecret:(NSString *)clientSecret;
- (BOOL)open:(NSURL *)url;
- (void)signInWithPresentingViewController:(UIViewController *)presentingViewController
                                   success:(nonnull void (^)(NSString *idToken, NSString *tid, NSString *tname))sucess
                                   failure:(nonnull void (^)(NSInteger code, NSString *message))failure;
@end

NS_ASSUME_NONNULL_END
