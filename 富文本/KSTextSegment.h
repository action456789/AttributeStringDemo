//
//  KSTextSegment.h
//  富文本
//
//  Created by KeSen on 15/9/16.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//  富文本中的一段文字

#import <Foundation/Foundation.h>

@interface KSTextSegment : NSObject

/**
 *  这段文字的内容
 */
@property (nonatomic, copy) NSString *text;

/**
 *  这段文字的范围
 */
@property (nonatomic, assign) NSRange range;

/**
 *  是否为特殊文字
 */
@property (nonatomic, assign, getter=isSpecial) BOOL special;

/**
 *  是否为表情
 */
@property (nonatomic, assign, getter=isEmotion) BOOL emotion;

@end
