//
//  NSString+VerificationVIN.h
//  TestVinalGorithm
//
//  Created by tigerzhang on 16/5/16.
//  Copyright © 2016年 Xcompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VerificationVIN)
// 汽车车辆识别代码验证
- (BOOL)ValidateVIN;

@end
