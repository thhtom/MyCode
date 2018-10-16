//
//  BaseView.h
//  LeChe
//
//  Created by yangxuran on 2018/3/15.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseView : NSObject

@end

@interface UILabel (BaseLabel)
+ (UILabel *)labelWithText:(NSString *)text fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment) textAlignment;

+ (UILabel *)labelWithText:(NSString *)text fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment) textAlignment frame:(CGRect)frame;
@end

@interface UIButton (BaseButton)
+ (UIButton *)buttonWithType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize target:(id)target action:(SEL)action frame:(CGRect)frame;

+ (UIButton *)buttonWithType:(UIButtonType)type image:(UIImage *)image;

+ (UIButton *)buttonWithType:(UIButtonType)type image:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize titleInset:(UIEdgeInsets)titleInset imageInset:(UIEdgeInsets)imageInset target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithType:(UIButtonType)type normalBackImage:(UIImage *)mormalBackImage selectBackImage:(UIImage *)seleteBackImage;
@end

@interface UIImageView (BaseImageView)
+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)contentMode isClip:(BOOL)isClip cornerRadius:(CGFloat)cornerRadius;
@end

@interface UITableView (BaseTableView)
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style delegate:(id)delegate dataSource:(id)dataSource;
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style delegate:(id)delegate dataSource:(id)dataSource frame:(CGRect)frame;
@end

@interface UITableViewCell (BaseTableViewCell)
+ (UITableViewCell *)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseID:(NSString *)reuseID;

+ (UITableViewCell *)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseID:(NSString *)reuseID frame:(CGRect)frame;
@end

@interface UIWebView (BaseWebView)
+ (UIWebView *)webViewWithFrame:(CGRect)frame delegate:(id)delegate;
@end

@interface UISearchBar (BaseSearchBar)
+ (UISearchBar *)searchBarWithFrame:(CGRect)frame delegate:(id)delegate placeholder:(NSString *)placeholder barStyle:(UISearchBarStyle)barStyle;
@end
