//
//  BFDPaperworkTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/4/13.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDPaperworkTableViewCell.h"

static CGFloat const aspectRatio = 658 / 362.0;
static NSString *const cellID = @"BFDPaperworkTableViewCell";

@interface BFDPaperworkTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UIImageView *originalImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *reuploadBtn;

@end

@implementation BFDPaperworkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.shadowColor = kShadowColor.CGColor;
    self.bgView.layer.shadowOpacity = 0.2;
    self.bgView.layer.shadowOffset = CGSizeMake(0, 0);
    //重新上传
    [self.reuploadBtn click:^(id value) {
        self.reuploadBlock(self);
    }];
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BFDPaperworkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDPaperworkTableViewCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

//原始数据
-(void)setOriginalDic:(NSDictionary *)originalDic{
    _originalDic = originalDic;
    
    self.originalImgView.image = Img(originalDic[@"image"]);
    self.titleLabel.text = originalDic[@"title"];
    UIImage *image = originalDic[@"iconImg"];
    if (image) {
        self.iconImgView.image = image;
        self.originalImgView.hidden = YES;
        self.titleLabel.hidden = YES;
        self.reuploadBtn.hidden = NO;
    }else{
        self.originalImgView.hidden = NO;
        self.titleLabel.hidden = NO;
        self.reuploadBtn.hidden = YES;
    }
}

//上传过图片数据
-(void)setImageStr:(NSString *)imageStr{
    if (imageStr.length > 0) {
        [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:Img(@"banner_placeholder")];
//        [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kBaseUrl,imageStr]] placeholderImage:Img(@"banner_placeholder")];
        self.originalImgView.hidden = YES;
        self.titleLabel.hidden = YES;
        self.reuploadBtn.hidden = YES;
    }else{
        self.originalImgView.hidden = NO;
        self.titleLabel.hidden = NO;
        self.titleLabel.text = @"银行卡(选填)";
        self.reuploadBtn.hidden = YES;
    }
}

//正在审核中
-(void)setIsReviewing:(BOOL)isReviewing{
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(22, 0, kUIScreenWidth - 44, (kUIScreenWidth - 44) / aspectRatio)];
    coverView.backgroundColor = RGBA(0, 0, 0, 0.5);
    [self addSubview:coverView];    
}

@end
