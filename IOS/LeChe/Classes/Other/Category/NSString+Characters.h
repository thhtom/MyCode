//
//  NSString+Characters.h
//  AddressBook
//
//  Created by Apple on 22/9/18.
//  Copyright © 2015年 HY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Characters)

//讲汉字转换为拼音
- (NSString *)pinyinOfName;

//汉字转换为拼音后，返回大写的首字母
- (NSString *)uppercasePinYinFirstLetter;

@end
