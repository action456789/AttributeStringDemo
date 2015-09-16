//
//  KSEmotion.h
//  富文本
//
//  Created by KeSen on 15/9/16.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KSEmotion : NSObject

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;

/** 表情的png图片名 */
@property (nonatomic, copy) NSString *png;

/** emoji表情的16进制编码 */
//@property (nonatomic, copy) NSString *code;

@end
