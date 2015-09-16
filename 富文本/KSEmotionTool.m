//
//  KSEmotionTool.m
//  富文本
//
//  Created by KeSen on 15/9/16.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSEmotionTool.h"
#import "KSEmotion.h"
#import "MJExtension.h"

@implementation KSEmotionTool

static NSArray *_defaultEmotions;

+ (NSArray *)defaultEmotions
{
    if (_defaultEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emotion.plist" ofType:nil];
        _defaultEmotions = [KSEmotion objectArrayWithFile:path];
    }
    return _defaultEmotions;
}

+ (KSEmotion *)emotionWithChs:(NSString *)chs {
    for (KSEmotion *e in [KSEmotionTool defaultEmotions]) {
        if ([e.chs isEqualToString:chs]) return e;
    }
    return nil;
}


@end
