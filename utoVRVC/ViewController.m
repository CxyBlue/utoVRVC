//
//  ViewController.m
//  utoVRVC
//
//  Created by 086 on 2017/6/21.
//  Copyright © 2017年 MCW. All rights reserved.
//

#import "ViewController.h"
#import <UtoVRPlayer/UtoVRPlayer.h>
#import "PlayerViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSString *onlineM3U8;
@end

@implementation ViewController

-(NSString *)onlineM3U8 {
    if (_onlineM3U8 == nil) {
        _onlineM3U8 = @"http://cache.utovr.com/201508270528174780.m3u8";
    }
    return _onlineM3U8;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton* imgBn=[[UIButton alloc]initWithFrame:CGRectMake(250, 300, 50, 50)];
    [imgBn setTitle:@"播放" forState:UIControlStateNormal];
    imgBn.backgroundColor = [UIColor redColor];
    [imgBn addTarget:self action:@selector(playeVdeo) forControlEvents:UIControlEventTouchUpInside];
    imgBn.tag = 11;
    [self.view addSubview:imgBn];
}
-(void)playeVdeo{
    
    UVPlayerViewStyle style = UVPlayerViewStyleDefault;
    NSMutableArray *items = [NSMutableArray array];
    
    UVPlayerItem *item = [[UVPlayerItem alloc] initWithPath:self.onlineM3U8 type:UVPlayerItemTypeOnline];
    [items addObject:item];
    
    PlayerViewController *playerVC = [[PlayerViewController alloc] init];
    [playerVC.itemsToPlay addObjectsFromArray:items];
    playerVC.player.viewStyle = style;
    
    [self.navigationController pushViewController:playerVC animated:YES];
    
    //[self presentViewController:playerVC animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
