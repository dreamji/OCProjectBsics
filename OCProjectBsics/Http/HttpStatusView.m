//
//  HttpStatusView.m
//  AiCommunity
//
//  Created by Tao on 2018/4/13.
//  Copyright © 2018年 NorthStar. All rights reserved.
//

#import "HttpStatusView.h"
#import "DGActivityIndicatorView.h"
#import "Common.h"
#import "BaseAppDelegate.h"

@interface HttpStatusView()
@property(nonatomic,strong) UIImageView *logoImageView;
@property(nonatomic,strong) DGActivityIndicatorView *indicatorView;

@property(nonatomic,strong) UILabel *messageLabel;
@property(nonatomic,strong) UILabel *serverMessageLabel;

@property(nonatomic,assign) NSString *message;
@property(nonatomic,assign) NSString *serverMessage;
@end


@implementation HttpStatusView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self buildLayout];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildLayout];
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self buildLayout];
}

- (void)buildLayout{
    self.backgroundColor = _RGB(0xeaeaea);
    [self addSubview:self.logoImageView];
    [self addSubview:self.messageLabel];
    [self addSubview:self.serverMessageLabel];
    [self.logoImageView addSubview:self.indicatorView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.indicatorView.center = CGPointMake(125, 125);
    self.logoImageView.frame = CGRectMake(self.width/2-125, self.height/2-250, 250, 250);
    self.messageLabel.frame = CGRectMake(20, _logoImageView.bottom + 30, self.width-40, _messageLabel.height);
    CGFloat offset = ((BaseAppDelegate *)[UIApplication sharedApplication].delegate).currentViewController.hidesBottomBarWhenPushed ? 0 : _BARH;
    self.serverMessageLabel.frame = CGRectMake(20, self.height - _serverMessageLabel.height - 20 - offset, self.width-40, _serverMessageLabel.height);
    
}

- (void)setViewMode:(HttpStatusViewDisplayMode)viewMode{
    _viewMode = viewMode;
    switch (viewMode) {
        case HttpStatusLoading:
        {
            self.indicatorView.hidden = false;
            [self.indicatorView startAnimating];
            self.logoImageView.image = nil;
        }break;
        case HttpStatusError:
        {
            self.indicatorView.hidden = true;
            [self.indicatorView stopAnimating];
            self.logoImageView.image = _IMG(@"public_fail_image");
        }break;
        case HttpStatusNoData:
        {
            self.indicatorView.hidden = true;
            [self.indicatorView stopAnimating];
            self.logoImageView.image = _IMG(@"public_nodata_image");
        }break;
        default:
            break;
    }
    
}

- (void)setMessage:(NSString *)message{
    self.messageLabel.text = message;
    self.messageLabel.height = [message sizeCalculate:_messageLabel.font width:self.width-40].height;
}

- (void)setServerMessage:(NSString *)serverMessage{
    self.serverMessageLabel.text = serverMessage;
    self.serverMessageLabel.height = [serverMessage sizeCalculate:_serverMessageLabel.font width:self.width-40].height;
}

- (void)showInView:(UIView *)view{
    [self showInView:view mode:HttpStatusLoading msg:@"加载中..."];
}
- (void)showInView:(UIView *)view mode:(HttpStatusViewDisplayMode)mode{
    [self showInView:view mode:mode msg:@""];
}
- (void)showInView:(UIView *)view mode:(HttpStatusViewDisplayMode)mode msg:(NSString *)msg{
    [self showInView:view mode:mode msg:msg note:@"" animate:true];
}
- (void)showInView:(UIView *)view mode:(HttpStatusViewDisplayMode)mode msg:(NSString *)msg note:(NSString *)note{
    [self showInView:view mode:mode msg:msg note:note animate:true];
}
- (void)showInView:(UIView *)view mode:(HttpStatusViewDisplayMode)mode msg:(NSString *)msg note:(NSString *)note animate:(BOOL)animate{
    if (view == nil) {[self remove];return;}
    if ( self.viewMode == mode && self.superview) {
        self.message = msg;
        self.serverMessage = note;
        return;
    }
    
    [view endEditing:true];
    [self removeFromSuperview];
    self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
    self.viewMode = mode;
    self.message = msg;
    self.serverMessage = note;
    [view addSubview:self];
    self.alpha = 0;
    if (animate) {
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 1;
        }];
    }else{
        self.alpha = 1;
    }
}

- (void)remove{
    [self.indicatorView stopAnimating];
    [self removeFromSuperview];
}


- (UIImageView *)logoImageView{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 250)];
        _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _logoImageView;
}

- (UILabel *)messageLabel{
    if (_messageLabel == nil) {
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.textColor = _RGB(0x6d6d6d);
    }
    return _messageLabel;
}

- (UILabel *)serverMessageLabel{
    if (_serverMessageLabel == nil) {
        _serverMessageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _serverMessageLabel.textAlignment = NSTextAlignmentCenter;
        _serverMessageLabel.numberOfLines = 0;
        _serverMessageLabel.font = [UIFont systemFontOfSize:14];
        _serverMessageLabel.textColor = _RGB(0x6d6d6d);
    }
    return _serverMessageLabel;
}

- (DGActivityIndicatorView *)indicatorView{
    if (_indicatorView == nil) {
        _indicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallSpinFadeLoader tintColor:_RGB(0x6d6d6d) size:50];
        _indicatorView.frame = CGRectMake(0, 0, 50, 50);
        _indicatorView.hidden = true;
    }
    return _indicatorView;
}



@end
