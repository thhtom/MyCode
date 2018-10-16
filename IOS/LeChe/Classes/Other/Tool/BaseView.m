//
//  BaseView.m
//  LeChe
//
//  Created by yangxuran on 2018/3/15.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

@end

@implementation UILabel (BaseLabel)

+ (UILabel *)labelWithText:(NSString *)text fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor    lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment) textAlignment {
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.textColor = textColor;
    label.font = fontSize;
    label.lineBreakMode = lineBreakMode;
    label.textAlignment = textAlignment;
    return label;
}

+ (UILabel *)labelWithText:(NSString *)text fontSize:(UIFont *)fontSize textColor:(UIColor *)textColor lineBreakMode:(NSLineBreakMode)lineBreakMode textAlignment:(NSTextAlignment) textAlignment frame:(CGRect)frame {
    UILabel *label = [UILabel labelWithText:text fontSize:fontSize textColor:textColor lineBreakMode:lineBreakMode textAlignment:textAlignment];
    label.frame = frame;
    return label;
}

@end

@implementation UIButton (BaseButton)

+ (UIButton *)buttonWithType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:type];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = titleSize;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithType:(UIButtonType)type title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize target:(id)target action:(SEL)action frame:(CGRect)frame {
    UIButton *button = [UIButton buttonWithType:type title:title titleColor:titleColor titleSize:titleSize target:target action:action];
    button.frame = frame;
    return button;
}

+ (UIButton *)buttonWithType:(UIButtonType)type image:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor titleSize:(UIFont *)titleSize titleInset:(UIEdgeInsets)titleInset imageInset:(UIEdgeInsets)imageInset target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:type title:title titleColor:titleColor titleSize:titleSize target:target action:action];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitleEdgeInsets:titleInset];
    [button setImageEdgeInsets:imageInset];
    return button;
}

+ (UIButton *)buttonWithType:(UIButtonType)type image:(UIImage *)image {
    UIButton *button = [UIButton buttonWithType:type];
    [button setImage:image forState:UIControlStateNormal];
    return button;
}

+ (UIButton *)buttonWithType:(UIButtonType)type normalBackImage:(UIImage *)mormalBackImage selectBackImage:(UIImage *)seleteBackImage {
    UIButton *button = [UIButton buttonWithType:type];
    [button setBackgroundImage:mormalBackImage forState:UIControlStateNormal];
    [button setBackgroundImage:seleteBackImage forState:UIControlStateSelected];
    return button;
}

@end

@implementation UIImageView (BaseImageView)

+ (UIImageView *)imageViewWithContentMode:(UIViewContentMode)contentMode isClip:(BOOL)isClip cornerRadius:(CGFloat)cornerRadius {
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.contentMode = contentMode;
    //是否裁剪圆角
    if (isClip) {
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = cornerRadius;
    }
    return imageView;
}

@end

@implementation UITableView (BaseTableView)

+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style delegate:(id)delegate dataSource:(id)dataSource {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:style];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    return tableView;
}

+ (UITableView *)tableViewWithStyle:(UITableViewStyle)style delegate:(id)delegate dataSource:(id)dataSource frame:(CGRect)frame {
    UITableView *tableView = [self tableViewWithStyle:style delegate:delegate dataSource:dataSource];
    tableView.frame = frame;
    return tableView;
}

@end

@implementation UITableViewCell (BaseTableViewCell)

+ (UITableViewCell *)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseID:(NSString *)reuseID {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[self alloc]initWithStyle:style reuseIdentifier:reuseID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

+ (UITableViewCell *)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style reuseID:(NSString *)reuseID frame:(CGRect)frame {
    UITableViewCell * cell = [self cellWithTableView:tableView style:style reuseID:reuseID];
    cell.frame = frame;
    return cell;
}

@end

@implementation UIWebView (BaseWebView)

+ (UIWebView *)webViewWithFrame:(CGRect)frame delegate:(id)delegate {
    UIWebView *webView = [[UIWebView alloc]initWithFrame:frame];
    webView.delegate = delegate;
    return webView;
}

@end

@implementation UISearchBar (BaseSearchBar)

+ (UISearchBar *)searchBarWithFrame:(CGRect)frame delegate:(id)delegate placeholder:(NSString *)placeholder barStyle:(UISearchBarStyle)barStyle {
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:frame];
    searchBar.delegate = delegate;
    searchBar.searchBarStyle = barStyle;
    searchBar.placeholder = placeholder;
    return searchBar;
}

@end
