//
//  KSEmotionTool.h
//  富文本
//
//  Created by KeSen on 15/9/16.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>
@class KSEmotion;

@interface KSEmotionTool : NSObject

+ (NSArray *)defaultEmotions;

/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+ (KSEmotion *)emotionWithChs:(NSString *)chs;

@end
