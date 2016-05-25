//
//  NSString+VerificationVIN.h
//
//  Created by tigerzhang on 16/5/16.
//  Copyright © 2016年 Xcompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (VerificationVIN)
// 验证车辆识别代码
- (BOOL)validateVIN;

@end
