//
//  BFDCommonProblemTableViewCell.m
//  LeChe
//
//  Created by yangxuran on 2018/5/7.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "BFDCommonProblemTableViewCell.h"
#import "BFDProblemModel.h"

static NSString *const cellID = @"BFDCommonProblemTableViewCell";

@interface BFDCommonProblemTableViewCell()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation BFDCommonProblemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.textView setEditable:NO];
    self.textView.scrollEnabled = NO;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    BFDCommonProblemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"BFDCommonProblemTableViewCell" owner:nil options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(void)setModel:(BFDProblemModel *)model{
    _model = model;
    
    self.textView.text = model.content;
}

@end
