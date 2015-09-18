//
//  KSSpecialStringRange.m
//  富文本
//
//  Created by KeSen on 15/9/17.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSSpecialText.h"

@implementation KSSpecialText

-(NSString *)description {
    return [NSString stringWithFormat:@"%@, %@", self.text, NSStringFromRange(self.range)];
}


@end
