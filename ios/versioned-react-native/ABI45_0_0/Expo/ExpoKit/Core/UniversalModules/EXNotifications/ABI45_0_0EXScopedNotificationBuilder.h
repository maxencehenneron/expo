// Copyright 2018-present 650 Industries. All rights reserved.

#if __has_include(<ABI45_0_0EXNotifications/ABI45_0_0EXNotificationBuilder.h>)

#import <ABI45_0_0EXNotifications/ABI45_0_0EXNotificationBuilder.h>
#import "ABI45_0_0EXConstantsBinding.h"

NS_ASSUME_NONNULL_BEGIN

@interface ABI45_0_0EXScopedNotificationBuilder : ABI45_0_0EXNotificationBuilder

- (instancetype)initWithScopeKey:(NSString *)scopeKey
                       andConstantsBinding:(ABI45_0_0EXConstantsBinding *)constantsBinding;

@end

NS_ASSUME_NONNULL_END

#endif
