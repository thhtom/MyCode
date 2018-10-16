//
//  BFDFeedbackView.m
//  LeChe
//
//  Created by yangxuran on 2018/3/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDFeedbackView.h"
#import "MyTextView.h"

@interface BFDFeedbackView()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet MyTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end


@implementation BFDFeedbackView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.backgroundColor = RGBA(0, 0, 0, 0.7);
    self.textView.backgroundColor = RGBColor(245, 245, 245);
    
    self.cancelBtn.layer.borderColor = RGBA(153, 153, 153, 1).CGColor;
    self.cancelBtn.layer.borderWidth = 1;
    
    self.textView.placeholder = @"请输入反馈内容";
    
    [self.cancelBtn click:^(id value) {
        [self removeFromSuperview];
    }];
    
    [self.commitBtn click:^(id value) {
        if (self.textView.text.length == 0) {
            [BOCProgressHUD boc_ShowError:@"请输入反馈内容"];
            return ;
        }
        if (self.commitBtn) {
            self.commitBlock(self.textView.text);
            [self removeFromSuperview];
        }
    }];
}

+(instancetype)createFeedBackView{
    return [[NSBundle mainBundle] loadNibNamed:@"BFDFeedbackView" owner:nil options:nil].firstObject;
}

@end
