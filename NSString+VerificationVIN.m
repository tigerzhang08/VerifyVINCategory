//
//  NSString+VerificationVIN.m
//
//  Created by tigerzhang on 16/5/16.
//  Copyright © 2016年 Xcompany. All rights reserved.
//

#import "NSString+VerificationVIN.h"

@implementation NSString (VerificationVIN)

- (BOOL)validateVIN {
    // 先用正则过滤 (只能包含0-9  A-H,J-N,P,R-Z 且必须为17位)
    NSString *vinRegex = @"^[A-HJ-NPR-Z0-9]{0,17}$";
    NSPredicate *vinTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", vinRegex];
    if(![vinTest evaluateWithObject:self] || self.length != 17) {
        return NO;
    }
    
    NSDictionary *alphabetDict = @{@"A":@1,
                                   @"B":@2,
                                   @"C":@3,
                                   @"D":@4,
                                   @"E":@5,
                                   @"F":@6,
                                   @"G":@7,
                                   @"H":@8,
                                   @"J":@1,
                                   @"K":@2,
                                   @"L":@3,
                                   @"M":@4,
                                   @"N":@5,
                                   @"P":@7,
                                   @"R":@9,
                                   @"S":@2,
                                   @"T":@3,
                                   @"U":@4,
                                   @"V":@5,
                                   @"W":@6,
                                   @"X":@7,
                                   @"Y":@8,
                                   @"Z":@9,
                                   };
    NSArray *weightArray = @[@8,@7,@6,@5,@4,@3,@2,@10,@0,@9,@8,@7,@6,@5,@4,@3,@2];
    
    NSInteger sum  = 0;
    for (NSInteger i = 0 ; i < 17; i++) {
        if (i == 8) { // 第九位不计入sum
            continue;
        }
        unichar indexChar = [self characterAtIndex:i];
        NSString *indexString = [NSString stringWithCharacters:&indexChar length:1];
        NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
        if ([letters characterIsMember:indexChar]) { // 字母
            indexString = [indexString uppercaseString]; // 转为大写
            NSNumber *valueNum = alphabetDict[indexString];
            sum += valueNum.integerValue * [weightArray[i] integerValue];
        }else { // 数字
            sum += indexString.integerValue * [weightArray[i] integerValue];
        }
    }
    
    unichar nineChar = [self characterAtIndex:8];
    NSString *nineString = [NSString stringWithCharacters:&nineChar length:1];
    NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
    if ([letters characterIsMember:nineChar]) {
        nineString = [nineString uppercaseString];
        if ([nineString isEqualToString:@"X"]) {
            nineString = @"10";
        }
    }
    if (sum % 11 == nineString.integerValue) {
        return YES;
    }else{
        return NO;
    }
}

@end
