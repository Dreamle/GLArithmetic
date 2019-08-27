//
//  ViewController.m
//  GLArithmetic
//
//  Created by admin on 2019/8/27.
//  Copyright © 2019年 admin. All rights reserved.
//

#import "ViewController.h"
#import "OperatorCaculateFraction.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSDictionary *dic = @{@"s1":@"3",@"s2":@"6",@"s3":@"2"};
    
    NSString *des = @"s1 + s1 * (s2 + s1 ) * 2 + (s2 / s3)";
    //1.分割
    NSArray *regexTempArr = [ViewController getTheRegexArrByPassStr:des];
    
    NSString *foumula = des;
    //2.替换公式中的字母
    for (NSString *regexStr in regexTempArr) {

        for (NSString *haveTheKey in dic) {
            if ([haveTheKey isEqualToString:regexStr]) {
                foumula = [foumula stringByReplacingOccurrencesOfString:regexStr withString:dic[haveTheKey]];
            }
        }
    }

    //3.1根据公式求解
    NSString *resultStep1 = [OperatorCaculateFraction calculateFraction:foumula errorString:nil];

    //3.2如果不是最终解，再次求解
    if ([resultStep1 containsString:@"/"]) {
        resultStep1 = [OperatorCaculateFraction fractionTranslatePoint:resultStep1];
    }
    
    
    NSLog(@"最后结果为：%@",resultStep1);
}




+ (NSArray *)getTheRegexArrByPassStr:(NSString *)passStr {
    
    NSString *reg = @"[a-z_A-Z0-9]+";
    
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:reg options:NSRegularExpressionCaseInsensitive error:nil];
    NSArray *all = [expression matchesInString:passStr options:kNilOptions range:NSMakeRange(0, passStr.length)];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for (NSTextCheckingResult *result in all) {
        NSString *sub = [passStr substringWithRange:result.range];
        [tempArr addObject:sub];
    }
    return tempArr;
}

@end
