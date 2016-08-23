//
//  LoginViewController.m
//  BBJ_Project
//
//  Created by BJB041511-032 on 16/4/3.
//  Copyright © 2016年 BJB041511-032. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfoEntity.h"

@interface LoginViewController ()

@property (nonatomic, strong) UILabel *titleDiscriptionLabel;
@property (nonatomic, strong) UITextField *phoneNumTextField;
@property (nonatomic, strong) UIView *seperatorLine;
@property (nonatomic, strong) UIButton *virifyButton;
@property (nonatomic, strong) UITextField *virifyCodeTextField;
@property (nonatomic, strong) UIButton *loginBtn;

@property (nonatomic, strong) UserInfoEntity *userInfoEntity;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpView
{
    [self addNavigationBar];
    [self addTitleDiscriptionLabel];
    [self addPhoneNumTextField];
    [self addVirifyButton];
    [self addSeperatorLine];
    [self addVirifyCodeTextField];
    [self addNextStepBtn];
    [self makeConstrain];
}

- (void)addNavigationBar
{
    [super addNavigationBar];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"Navtitle"];
    
    imageView.width = imageView.image.size.width;
    imageView.height = imageView.image.size.height;
    
    imageView.left = self.navigationBar.titleView.width/2 - imageView.width/2;
    imageView.centerY = self.navigationBar.titleView.centerY;
    
    [self.navigationBar.titleView addSubview:imageView];
    
}

- (void)addTitleDiscriptionLabel
{
    self.titleDiscriptionLabel = [[UILabel alloc] init];
    self.titleDiscriptionLabel.font = FONT(16);
    self.titleDiscriptionLabel.text = @"请使用您的手机号\n登录宝贝佳";
    self.titleDiscriptionLabel.textAlignment = NSTextAlignmentCenter;
    self.titleDiscriptionLabel.numberOfLines = 0;
    [self.view addSubview:self.titleDiscriptionLabel];
}

- (void)addVirifyButton
{
    self.virifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.virifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.virifyButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.virifyButton.layer.cornerRadius = 3;
    [self.virifyButton addTarget:self action:@selector(touchVirifyButton:) forControlEvents:UIControlEventTouchUpInside];
    self.virifyButton.backgroundColor = RGB(239, 84, 97);
    [self.view addSubview:self.virifyButton];
    
}

- (void)addPhoneNumTextField
{
    self.phoneNumTextField = [[UITextField alloc] init];
    self.phoneNumTextField.placeholder = @"请输入手机号码";
    self.phoneNumTextField.font = FONT(22);
    [self.view addSubview:self.phoneNumTextField];
    
}

- (void)addSeperatorLine
{
    self.seperatorLine = [[UIView alloc] init];
    self.seperatorLine.backgroundColor = RGB(237, 237, 237);
    [self.view addSubview:self.seperatorLine];
    
}

- (void)addVirifyCodeTextField
{
    self.virifyCodeTextField = [[UITextField alloc] init];
    self.virifyCodeTextField.placeholder = @"请输验证码";
    self.virifyCodeTextField.font = FONT(22);
    [self.view addSubview:self.virifyCodeTextField];
    
}

-(void)addNextStepBtn
{
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.loginBtn.layer.cornerRadius = 3;
    [self.loginBtn addTarget:self action:@selector(touchLoginpBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.loginBtn.backgroundColor = RGB(239, 84, 97);
    [self.view addSubview:self.loginBtn];
    
}
/**
 *  添加约束
 */
- (void)makeConstrain
{
    __weak typeof (self) weakSelf = self;
    [self.titleDiscriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view.mas_right).offset(-16);
        make.top.equalTo(weakSelf.view.mas_top).offset(64+20);
        make.height.equalTo(@40);
    }];
    
    [self.virifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.right.equalTo(weakSelf.view.mas_right).offset(-16);
        make.top.equalTo(weakSelf.titleDiscriptionLabel.mas_bottom).offset(26);
        make.height.equalTo(@36);
    }];
    
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.titleDiscriptionLabel.mas_bottom).offset(20);
        make.left.equalTo(weakSelf.view).offset(16);
        make.right.equalTo(weakSelf.view.mas_right).offset(-16);
        make.height.equalTo(@50);
    }];
    
    [self.seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.phoneNumTextField.mas_left);
        make.right.equalTo(weakSelf.view.mas_right).offset(-16);
        make.top.equalTo(weakSelf.phoneNumTextField.mas_bottom).offset(2);
        make.height.equalTo(@0.5);
    }];
    
    [self.virifyCodeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.seperatorLine.mas_bottom);
        make.left.equalTo(weakSelf.seperatorLine.mas_left);
        make.right.equalTo(weakSelf.seperatorLine.mas_right);
        make.height.equalTo(@50);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.seperatorLine.mas_left);
        make.right.equalTo(weakSelf.seperatorLine.mas_right);
        make.top.equalTo(weakSelf.virifyCodeTextField.mas_bottom).offset(20);
        make.height.equalTo(@50);
    }];
}
#pragma mark - nextbutton action
/**
 *  获取验证码按钮方法
 *
 *  @param button button
 */
- (void)touchVirifyButton:(UIButton *)button
{
    [LoginModuleRequest getVerificationWithPhoneNum:@"15210181507" succeeded:^(NSDictionary *resultOject) {
        
    } failed:^(NSError *error) {
        
    }];
}
/**
 *  登录按钮点击方法
 *
 *  @param button button
 */
- (void)touchLoginpBtn:(UIButton *)button
{
   // NSString *phoneNum = self.phoneNumTextField.text;
    NSString *passCode = self.virifyCodeTextField.text;
    [LoginModuleRequest postLoginInfoWithPhoneNum:@"15210181507"
                                         passCode:passCode
                                        succeeded:^(NSDictionary *resultOject) {
                                            UserInfoEntity *entity = [[UserInfoEntity alloc] initWithDictionary:[resultOject objectForKey:@"data"]];
                                           
    }
                                          failed:^(NSError *error) {
                                              
                                          }];
}
@end
