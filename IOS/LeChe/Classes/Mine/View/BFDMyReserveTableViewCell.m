//
//  BFDMyReserveTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/3/22.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDMyReserveTableViewCell.h"
#import "BFDMyReserveModel.h"

static NSString *const identifier = @"BFDMyReserveTableViewCell";

@interface BFDMyReserveTableViewCell()

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *statusImgView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *changeBtn;


@end

@implementation BFDMyReserveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self configureUI];
}

-(void)configureUI{
    
    //按钮样式
    self.rightBtn.layer.borderWidth = 0.5;
    self.rightBtn.layer.borderColor = RGBColor(153, 153, 153).CGColor;
    
    self.changeBtn.backgroundColor = RGBA(51, 51, 51, 1);
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BFDMyReserveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDMyReserveTableViewCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setModel:(BFDMyReserveModel *)model{
    _model = model;
    
    self.dateLabel.text = model.addtime;
    
    //状态(0:预约中,1:邀请中,2:已体验,3:已取消,4:未通过,5:已下单,6:已过期，8:预约中)
    if ([[AccountTool sharedAccountTool].account.is_authentication isEqualToString:@"2"]) {
        self.statusLabel.text = @"未通过";
        self.statusImgView.image = Img(@"reserve_notpass");
        [self.rightBtn setTitle:@"查看原因" forState:UIControlStateNormal];
        self.bottomView.hidden = NO;
        
        self.changeBtn.hidden = NO;
        [self.changeBtn setTitle:@"重新提交" forState:UIControlStateNormal];
        
        //重新提交
        [self.changeBtn click:^(id value) {
            [self changeReserve];
        }];
        
        //查看原因
        [self.rightBtn click:^(id value) {
            [self seeReason];
        }];
    }else{
        switch ([model.status integerValue]) {
            case 0:{
                self.statusLabel.text = @"预约中";
                self.statusImgView.image = Img(@"reserve_reserving");
                [self.rightBtn setTitle:@"取消预约" forState:UIControlStateNormal];
                self.bottomView.hidden = NO;
                self.statusImgView.image = Img(@"reserve_reserving");
                
                if ([[AccountTool sharedAccountTool].account.is_authentication isEqualToString:@"0"]) {
                    self.changeBtn.hidden = NO;
                    [self.changeBtn setTitle:@"提交资料" forState:UIControlStateNormal];
                }else{
                    self.changeBtn.hidden = YES;
                }
                
                //提交资料
                [self.changeBtn click:^(id value) {
                    [self changeReserve];
                }];
                //取消预约
                [self.rightBtn click:^(id value) {
                    [self cancelReserve];
                }];
            }
                break;
            case 1:{
                self.statusLabel.text = @"邀请中";
                self.statusImgView.image = Img(@"reserve_invite");
                [self.rightBtn setTitle:@"取消预约" forState:UIControlStateNormal];
                self.changeBtn.hidden = YES;
                self.bottomView.hidden = YES;
                
                //            //取消预约
                //            [self.rightBtn click:^(id value) {
                //                [self cancelReserve];
                //            }];
            }
                break;
            case 2:{
                self.statusLabel.text = @"已体验";
                self.statusImgView.image = Img(@"reserve_complete");
                self.changeBtn.hidden = YES;
                self.bottomView.hidden = YES;
            }
                break;
            case 3:{
                self.statusLabel.text = @"已取消";
                self.statusImgView.image = Img(@"reserve_cancel");
                [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
                self.changeBtn.hidden = YES;
                self.bottomView.hidden = NO;
                
                //删除
                [self.rightBtn click:^(id value) {
                    [self deleteReason];
                }];
            }
                break;
            case 4:{
                self.statusLabel.text = @"未通过";
                self.statusImgView.image = Img(@"reserve_notpass");
                [self.rightBtn setTitle:@"查看原因" forState:UIControlStateNormal];
                self.bottomView.hidden = NO;
                
                self.changeBtn.hidden = NO;
                [self.changeBtn setTitle:@"重新提交" forState:UIControlStateNormal];
                
                //重新提交
                [self.changeBtn click:^(id value) {
                    [self changeReserve];
                }];
                
                //查看原因
                [self.rightBtn click:^(id value) {
                    [self seeReason];
                }];
            }
                break;
            case 5:{
                self.statusLabel.text = @"已下单";
                self.statusImgView.image = Img(@"reserve_complete");
                [self.rightBtn setTitle:@"查看订单" forState:UIControlStateNormal];
                self.changeBtn.hidden = YES;
                self.bottomView.hidden = NO;
            
                self.rightBtn.backgroundColor = RGBA(51, 51, 51, 1);
                
                //查看订单
                [self.rightBtn click:^(id value) {
                    [self seeorder];
                }];
            }
                break;
            case 6:{
                self.statusLabel.text = @"已过期";
                self.statusImgView.image = Img(@"reserve_cancel");
                [self.rightBtn setTitle:@"删除" forState:UIControlStateNormal];
                self.changeBtn.hidden = YES;
                self.bottomView.hidden = NO;
                
                self.rightBtn.layer.borderColor = RGBColor(255, 99, 42).CGColor;
                [self.rightBtn setTitleColor:RGBColor(255, 99, 42) forState:UIControlStateNormal];
                
                //删除
                [self.rightBtn click:^(id value) {
                    [self deleteReason];
                }];
            }
                break;
            case 8:{
                self.statusLabel.text = @"预约中";
                self.statusImgView.image = Img(@"reserve_reserving");
                [self.rightBtn setTitle:@"取消预约" forState:UIControlStateNormal];
                self.bottomView.hidden = NO;
                self.statusImgView.image = Img(@"reserve_reserving");
                
                if ([[AccountTool sharedAccountTool].account.is_authentication isEqualToString:@"0"] || [[AccountTool sharedAccountTool].account.is_authentication isEqualToString:@"2"]) {
                    self.changeBtn.hidden = NO;
                }else{
                    self.changeBtn.hidden = YES;
                }
                
                //提交资料
                [self.changeBtn click:^(id value) {
                    [self changeReserve];
                }];
                //取消预约
                [self.rightBtn click:^(id value) {
                    [self cancelReserve];
                }];
            }
                break;
                
            default:{
                self.statusLabel.text = @"已完成";
                self.statusImgView.image = Img(@"reserve_complete");
                self.changeBtn.hidden = YES;
                self.bottomView.hidden = YES;
            }
                break;
        }
    }
    
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:model.pic_url] placeholderImage:Img(@"car_placeholder")];
    self.titleLabel.text = model.brand_name;
    self.brandLabel.text = model.des;
    self.siteLabel.text = model.c_name;
}

#pragma mark - 上传证件
-(void)changeReserve{
    if (self.uploadPaperworkBlock) {
        self.uploadPaperworkBlock();
    }
}

#pragma mark - 取消预约
-(void)cancelReserve{
    if (self.cancelReserveBlock) {
        self.cancelReserveBlock();
    }
}

#pragma mark - 查看原因
-(void)seeReason{
    if (self.seeReasonBlock) {
        self.seeReasonBlock();
    }
}

#pragma mark - 删除
-(void)deleteReason{
    if (self.delegeBlock) {
        self.delegeBlock();
    }
}

#pragma mark - 查看订单
-(void)seeorder{
    if (self.seeOrderBlock) {
        self.seeOrderBlock();
    }
}

@end
