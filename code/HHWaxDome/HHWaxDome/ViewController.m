//
//  ViewController.m
//  HHWaxDome
//
//  Created by caohuihui on 16/3/22.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

#import "ViewController.h"
#import <wax/wax.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()
{
    dispatch_queue_t _queue;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _queue=dispatch_queue_create("downloadFile", nil);
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 64, 100, 100)];
    [button addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor=[UIColor redColor];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton * button1 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, 64, 100, 100)];
    [button1 addTarget:self action:@selector(clickButton1) forControlEvents:UIControlEventTouchUpInside];
    button1.backgroundColor=[UIColor blueColor];
    [button1 setTitle:@"跳转,蓝色" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    
    UIButton * button2 = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height-100, 100, 100)];
    [button2 addTarget:self action:@selector(clickButton2) forControlEvents:UIControlEventTouchUpInside];
    button2.backgroundColor=[UIColor greenColor];
    [button2 setTitle:@"跳转,绿色" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    
    
    UIButton * button3 = [[UIButton alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-100, 100, 100)];
    [button3 addTarget:self action:@selector(clickButton3) forControlEvents:UIControlEventTouchUpInside];
    button3.backgroundColor=[UIColor purpleColor];
    [button3 setTitle:@"跳转,紫色" forState:UIControlStateNormal];
    [self.view addSubview:button3];
}

-(void)clickButton1{
    [self downloadFileWithUrlString:@"http://caohuihui.com/download/push.lua"];
}

-(void)clickButton2{
    [self downloadFileWithUrlString:@"http://caohuihui.com/download/push2.lua"];
}

-(void)clickButton3{
    [self downloadFileWithUrlString:@"http://caohuihui.com/download/push3.lua"];
}


-(void)downloadFileWithUrlString:(NSString *)urlString{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    __weak typeof(self)weakSelf=self;
    dispatch_async(_queue, ^{
        NSURL *url = [NSURL URLWithString:urlString];
        
        NSString * code=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSString *filePath=[NSString stringWithFormat:@"%@/Documents/push.lua",NSHomeDirectory()];
        [code writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"%@",NSStringFromSelector(_cmd));
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        });
    });

}

-(void)clickButton{
    NSString *filePath=[NSString stringWithFormat:@"%@/Documents/push.lua",NSHomeDirectory()];
    char * fileChar =  (char *)[filePath cStringUsingEncoding:NSUTF8StringEncoding];
    wax_start(fileChar, nil);
    wax_end();
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
