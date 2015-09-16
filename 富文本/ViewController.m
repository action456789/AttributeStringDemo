//
//  ViewController.m
//  富文本
//
//  Created by KeSen on 15/9/15.
//  Copyright (c) 2015年 KeSen. All rights reserved.
//

#import "ViewController.h"
#import "RegexKitLite.h"
#import "KSTextSegment.h"

@interface ViewController ()
{
    NSString *_text;
//    NSAttributedString *attributeText;
    UILabel *_label;
}
@end

#define kFont [UIFont systemFontOfSize:15]

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _text = @"#呵呵呵#[偷笑] http://foo.com/blah_blah #解放军#//http://foo.com/blah_blah @Ring花椰菜:就#范德萨发生的#舍不得打[test] 就惯#急急急#着他吧[挖鼻屎]//@崔西狮:小拳头举起又放下了 说点啥好呢…… //@toto97:@崔西狮 蹦米咋不揍他#哈哈哈# http://foo.com/blah_blah";
   
    _label = [[UILabel alloc] init];
    _label.attributedText = [self attributeStringWithText:_text];
    
//    CGSize textSize = [self.label.text boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:nil].size;
    
    // 计算属性文字的 size
    CGSize attributeTextSize = [_label.attributedText boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    _label.numberOfLines = 0;
    _label.font = kFont;
    _label.frame = CGRectMake(20, 40, 300, attributeTextSize.height);
    
    
    [self.view addSubview:_label];

}

/* 对于表情文字的处理
 要点1：不能使用 attributeText replaceCharactersInRange:<#(NSRange)#> withString:<#(NSString *)#>
 
 因为：如果有多个表情文字，替换了前面的表情文字为图片后，整个富文本长度将发生变化，后面的表情文字 range 就发生变化了，再拼接会出现错乱。
 
 解决思路：先将所有特殊文字和非特殊文字拿出来，然后从前往后（根据range可以知道顺序），一个个进行拼接。
 */
- (NSAttributedString *)attributeStringWithText:(NSString *)text {
    
    // 表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]"; // \\u4e00-\\u9fa5 表示所有中文，\\[ 表示[的转义
    // @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5]+";
    // #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
    // url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];

    NSMutableArray *parts = [NSMutableArray array];
    
    // 使用正则表达式遍历特殊字符
    [_text enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
        if ((*capturedStrings).length == 0) return;
        
        KSTextSegment *seg = [[KSTextSegment alloc] init];
        seg.text = *capturedStrings;
        seg.range = *capturedRanges;
        seg.special = YES;
        
        [parts addObject:seg];
    }];
    
    // 按照正则表达式遍历所有非特殊字符
    [_text enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
       
        if ((*capturedStrings).length == 0) return;
       
        KSTextSegment *seg = [[KSTextSegment alloc] init];
        seg.text = *capturedStrings;
        seg.range = *capturedRanges;
        seg.special = NO;
        
        [parts addObject:seg];
    
    }];

    // 排序
    [parts sortedArrayUsingComparator:^NSComparisonResult(KSTextSegment *obj1, KSTextSegment *obj2) {
        if (obj1.range.location > obj2.range.location) {
            return NSOrderedDescending; // 大的放后面
        }
        return NSOrderedAscending;
        // return obj1.range.location > obj2.range.location ? NSOrderedDescending : NSOrderedAscending;
    }];
    
    NSLog(@"%@", parts);
    
    NSMutableAttributedString *attributeText = [[NSMutableAttributedString alloc] init];
    // 设置字体
    [attributeText addAttribute:NSFontAttributeName value: kFont range: NSMakeRange(0, attributeText.length)];
    
    // 按顺序拼接文字
    for (KSTextSegment *seg in parts) {
        // 特殊文字
        if (seg.isSpecial) {
            
        } else { // 非特殊文字

            [attributeText appendAttributedString: [[NSAttributedString alloc] initWithString:seg.text]];
        }
    }
    
    NSTextAttachment *attatchment = [[NSTextAttachment alloc] init];
    attatchment.image = [UIImage imageNamed:@"d_aini"];
    [attributeText appendAttributedString:[NSMutableAttributedString attributedStringWithAttachment:attatchment]];
    
    return attributeText;
}

@end
