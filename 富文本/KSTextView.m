//
//  KSTextView.m
//  富文本
//
//  Created by KeSen on 15/9/16.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "KSTextView.h"
#import "KSSpecialText.h"


#define kCoverViewTag 999

@implementation KSTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.scrollEnabled = NO;
        
        self.editable = NO;
        
        // 消除内边距，不然计算文字宽度会不正确
        self.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    CGPoint touchP = [[touches anyObject]locationInView:self];
    
    // 取出非表情特殊文本数组
    NSArray *specials = [self.attributedText attribute:@"specileTexts" atIndex:0 effectiveRange:NULL];
    
    BOOL touchInAttributeTextSeg = NO;  // 点击的位置是否在特殊文本的矩形范围内
    
    // 计算所有特殊文本矩形范围
    for (KSSpecialText *special in specials) {
        // 取出特殊文字模型
        self.selectedRange = special.range;  // 通过修改 selectedRange 的值，可以修改 selectedTextRange 的值
        // 根据特殊文字计算文本矩形范围
        NSArray *rects = [self selectionRectsForRange:self.selectedTextRange];
        
        for (UITextSelectionRect *rect in rects) {
            CGRect r = rect.rect;
        
            // 清空选中范围
            self.selectedRange = NSMakeRange(0, 0);
            
            if (r.size.width == 0 || r.size.height == 0) continue;
            
            if (CGRectContainsPoint(r, touchP)) {
                touchInAttributeTextSeg = YES;
                break;
            }
        }
        
        if (touchInAttributeTextSeg) {
            for (UITextSelectionRect *rect in rects) {
                CGRect r = rect.rect;
                
                // 给选中的文本添加一层 view
                UIView *view = [[UIView alloc] initWithFrame:r];
                view.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3f];
                view.layer.cornerRadius = 4.0;
                view.tag = kCoverViewTag;
                [self addSubview:view];
            }
            
            break;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UIView *view in self.subviews) {
        if (view.tag == kCoverViewTag) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [view removeFromSuperview];
            });
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

@end
