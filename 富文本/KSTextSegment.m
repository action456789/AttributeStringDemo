//
//  KSTextSegment.m
//  富文本
//
//  Created by KeSen on 15/9/16.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSTextSegment.h"

@implementation KSTextSegment

-(NSString *)description {
    return [NSString stringWithFormat:@"%@, %@", self.text, NSStringFromRange(self.range)];
}

@end
