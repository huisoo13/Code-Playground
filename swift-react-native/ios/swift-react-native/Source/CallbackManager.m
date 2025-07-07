//
//  CallbackManager.m
//  swift-react-native
//
//  Created by Huisoo on 7/7/25.
//

#import <React/RCTBridgeModule.h>

// CallbackManager를 React Native 브릿지에 노출시키는 코드
@interface RCT_EXTERN_MODULE(CallbackManager, NSObject)

// executeCallback 함수를 노출시키는 코드
RCT_EXTERN_METHOD(executeCallback:(NSString *)message
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)

@end
