//
//  GJBaseView.h
//  CPH
//
//  Created by gaojun on 16/6/30.
//  Copyright © 2016年 gaojun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJBaseView : NSObject

@end

@interface UILabel (GJLabel)
+ (UILabel *)labelWithText:(NSString *)text fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment) textAlignment;

+ (UILabel *)labelWithText:(NSString *)text fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment) textAlignment frame:(CGRect)frame;
@end

@interface UIButton (GJButton)
+ (UIButton *)buttonWithType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize target:(id)target action:(SEL)action frame:(CGRect)frame;

+ (UIButton *)buttonWithType:(UIButtonType)type image:(UIImage *)image;

+ (UIButton *)buttonWithType:(UIButtonType)type image:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize titleInset:(UIEdgeInsets)titleInset imageInset:(UIEdgeInsets)imageInset target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithType:(UIButtonType)type normalBackImage:(UIImage *)mormalBackImage selectBackImage:(UIImage *)seleteBackImage;
@end

@interface UIImageView (GJImageView)
+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)contentMode isClip:(BOOL)isClip cornerRadius:(CGFloat)cornerRadius;
@end

@interface UITableView (GJTableView)
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style delegate:(id)delegate dataSource:(id)dataSource;
+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style delegate:(id)delegate dataSource:(id)dataSource frame:(CGRect)frame;
@end

@interface UITableViewCell (GJTableViewCell)
+ (UITableViewCell *)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseID:(NSString *)reuseID;

+ (UITableViewCell *)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseID:(NSString *)reuseID frame:(CGRect)frame;
@end

@interface UIWebView (GJWebView)
+ (UIWebView *)webViewWithFrame:(CGRect)frame delegate:(id)delegate;
@end

@interface UISearchBar (GJSearchBar)
+ (UISearchBar *)searchBarWithFrame:(CGRect)frame delegate:(id)delegate placeholder:(NSString *)placeholder barStyle:(UISearchBarStyle)barStyle;
@end
