//
//  AppDelegate.h
//  jishiben
//
//  Created by songdaozhang on 16/1/22.
//  Copyright © 2016年 songdaozhang. All rights reserved.
//

#import "ViewController.h"
#import "CustomAlter.h"
#import "Masonry.h"
#import "ContactModel.h"

@interface ViewController ()
{
    NSString *_memCardIdPath;
    UITextField *_cardIdInput;
    UITextField *_nameInput;
    NSString *_basePath;
}

@property (nonatomic,strong)NSMutableArray *memeCardIds;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _memCardIdPath = @"/Users/Macx/Desktop/cardId.info";
    _basePath = [@"/Users/Macx/Desktop" stringByAppendingPathComponent:@"Models"];
    if(![[NSFileManager defaultManager]fileExistsAtPath:_basePath]){
        
        [[NSFileManager defaultManager]createDirectoryAtPath:_basePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    [self baseUIConfig];
    
    if(![[NSFileManager defaultManager]fileExistsAtPath:_memCardIdPath]){
        
        NSMutableArray *t = [NSMutableArray array];
        [NSKeyedArchiver archiveRootObject:t toFile:_memCardIdPath];
    }
    
    _memeCardIds = self.memeCardIds;
    
    
    
}


#pragma mark - buttonClicked
- (void)buttonClicked:(UIButton *)sender{
    
    if([sender.currentTitle isEqualToString:@"save"]){//save
        
        if(_nameInput.text.length == 0 || _cardIdInput.text.length == 0){
        
            [self showAlert];//弹出警告视图
            return;
        }
        
        if([self.memeCardIds containsObject:_cardIdInput.text]){
            
            [self showAlert];//弹出警告视图
            return;
        }
    
        ContactModel *model = [ContactModel contactModelWithCardId:_cardIdInput.text andName:_nameInput.text];
        
        [self.memeCardIds addObject:model.cardId];
        NSString *modelPath = [_basePath stringByAppendingPathComponent:[self.memeCardIds lastObject]];
        [NSKeyedArchiver archiveRootObject:model toFile:modelPath];
        
        [NSKeyedArchiver archiveRootObject:self.memeCardIds toFile:_memCardIdPath];
        NSLog(@"保存成功");
    }else if ([sender.currentTitle isEqualToString:@"find"]){//查询
        
        if(_cardIdInput.text.length == 0){
        
            [self showAlert];//
            return;
        }
        
        if(![self.memeCardIds containsObject:_cardIdInput.text]){
            
            [self showAlert];//
            return;
        }
        
        NSString *filePath = [_basePath stringByAppendingPathComponent:_cardIdInput.text];
        
        ContactModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        
        _nameInput.text = model.name;
        NSLog(@"查询成功!");
        
    }
   
    
}




- (void)baseUIConfig{

    _cardIdInput = [self textFiledWithPlaceHolder:@"please input cardId"];
    [self.view addSubview:_cardIdInput];
    [_cardIdInput mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(@20);
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.height.equalTo(@50);
    }];
    
    
    _nameInput = [self textFiledWithPlaceHolder:@"place input name"];
    [self.view addSubview:_nameInput];
    [_nameInput mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_cardIdInput.mas_bottom).with.offset(20);
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.height.equalTo(@50);
    }];
    
    
    UIButton *saveButton = [self buttonWithTitle:@"save"];
    [self.view addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_nameInput.mas_bottom).with.offset(20);
        make.left.equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
    
    UIButton *findButton = [self buttonWithTitle:@"find"];
    [self.view addSubview:findButton];
    [findButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(saveButton.mas_top);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.left.equalTo(saveButton.mas_right).with.offset(20);
        
    }];
    
}



- (UIButton *)buttonWithTitle:(NSString *)title{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UITextField *)textFiledWithPlaceHolder:(NSString*)placeHolder{
    
    UITextField *textFile = [UITextField new];
    textFile.clearButtonMode = UITextFieldViewModeAlways;
    textFile.placeholder = placeHolder;
    textFile.backgroundColor = [UIColor blueColor];
    
    return textFile;
}




- (void)showAlert{
    
    CustomAlter *alter = [CustomAlter alertWithTitle:@"test" andMessage:@"message" andCallBack:^(UIAlertAction *action) {
        
        NSLog(@"...");
    }];
    
    [self presentViewController:alter animated:YES completion:nil];
}

- (NSMutableArray *)memeCardIds{
    
    if(!_memeCardIds){
        
        _memeCardIds = [NSKeyedUnarchiver unarchiveObjectWithFile:_memCardIdPath];
    }
    
    return _memeCardIds;
}


@end
