//
//  ReactNativeModule.m
//  swift-react-native
//
//  Created by Huisoo on 7/7/25.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(ReactNativeModule, RCTEventEmitter)

RCT_EXTERN_METHOD(timer)
RCT_EXTERN_METHOD(callback:(NSString *)input
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
RCT_EXTERN_METHOD(call:(NSString *)method
                  parameters:(NSDictionary *)parameters)
@end
