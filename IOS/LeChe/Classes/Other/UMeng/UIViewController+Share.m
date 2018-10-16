//
//  UIViewController+Share.m
//  LeChe
//
//  Created by yangxuran on 2018/4/27.
//  Copyright © 2018年 yangxuran. All rights reserved.
//

#import "UIViewController+Share.h"
#import <UShareUI/UShareUI.h>

@implementation ShareModel

- (NSArray *)type {
    if (!_type) {
        return @[@"qzone", @"qq", @"wxtimeline", @"wxsession", @"sms", @"sina", @"tencent", @"renren"];
    }
    
    return _type;
}

- (NSString *)img {
    if (!_img) {
        return @"";
    }
    
    return _img;
}

- (NSString *)content {
    if (!_content) {
        return @"";
    }
    
    return _content;
}

+ (instancetype)shareModelWithTitle:(NSString *)title content:(NSString *)content url:(NSString *)url img:(NSString *)img {
    ShareModel *shareModel = [ShareModel new];
    shareModel.title = title;
    shareModel.content = content;
    shareModel.url = url;
    shareModel.img = img;
    return shareModel;
}
@end

@implementation UIViewController (Share)

/**
 基于友盟平台的微信，QQ，微博分享
 
 @param obj 待分享的对象实体
 */
- (void)umShare:(id)obj {
    
    //分享面板加入自定义图标事件
    [UMSocialUIManager addCustomPlatformWithoutFilted:UMSocialPlatformType_UserDefine_Begin+2
                                     withPlatformIcon:[UIImage imageNamed:@"umsocial_copy"]
                                     withPlatformName:@"复制链接"];
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
    
    //预设置分享平台
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_Sina)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        NSLog(@"userInfo:%@",userInfo);
        if (platformType == UMSocialPlatformType_UserDefine_Begin+2) {
            NSLog(@"do your operation for copy");
            //复制链接操作
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            ShareModel *sm = (ShareModel *)obj;
            if (sm.url.length == 0) {
                pasteboard.string = @"";
            }else{
                pasteboard.string = sm.url;
            }
            [BOCProgressHUD boc_showText:@"链接已复制"];
        } else {
            [self shareWebPageToPlatformType:platformType content:obj];
        }
    }];
}

//分享网页
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType content:(ShareModel *)content
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //image处理
    NSData  *data;
    UIImage *image;
    
    if ([content.img containsString:@"http"]) {
        data = [NSData dataWithContentsOfURL:[NSURL URLWithString:content.img]];
        image = [UIImage imageWithData:data];
    } else {
        image = [UIImage imageNamed:content.img];
    }
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:content.title descr:content.content thumImage:image];
    //设置网页地址
    shareObject.webpageUrl = content.url;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];

}

@end
