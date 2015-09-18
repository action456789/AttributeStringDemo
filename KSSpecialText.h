//
//  KSSpecialStringRange.h
//  富文本
//
//  Created by KeSen on 15/9/17.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSSpecialText : NSObject

/** 这段特殊文字的内容 */
@property (nonatomic, copy  ) NSString *text;

/** 这段特殊文字的范围 */
@property (nonatomic, assign) NSRange  range;

/***  这段特殊文本在整个文本中的矩形框*/
@property (nonatomic, strong) NSArray  *rects;

@end
