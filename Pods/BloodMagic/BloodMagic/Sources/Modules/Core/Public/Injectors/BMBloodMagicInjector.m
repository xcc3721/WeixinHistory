//
// Created by Alex Denisov on 17.07.13.
// Copyright (c) 2013 railsware. All rights reserved.
//

#import "BMBloodMagicInjector.h"
#import "BMClassCollector.h"
#import "BMKVCInjector.h"
#import "BMDynamicPropertyInjector.h"

@implementation BMBloodMagicInjector
{
    BMClassCollector *classCollector;
    BMKVCInjector *kvcInjector;
    BMDynamicPropertyInjector *propertyInjector;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        classCollector = [BMClassCollector new];
        kvcInjector = [BMKVCInjector new];
        propertyInjector = [BMDynamicPropertyInjector new];
    }

    return self;
}

- (void)injectBloodMagicInto:(Protocol *)protocol {
    return [self injectBloodMagicInto:protocol excluding:nil];
}

- (void)injectBloodMagicInto:(Protocol *)protocol excluding:(Protocol *)excludingProtocol
{
    NSArray *classes = [classCollector collectForProtocol:protocol];
    for (Class klass in classes) {
        [kvcInjector injectKVCHandlersIntoClass:klass];
        [propertyInjector injectDynamicHandlersIntoClass:klass withProtocol:protocol excludingProtocol:excludingProtocol];
    }
}

@end