//
//  RootTableViewController.m
//  UtoVRPlayerDemo
//
//  Created by administrator on 12/14/15.
//  Copyright © 2015 xue. All rights reserved.
//

#import "TestTableViewController.h"
#import <UtoVRPlayer/UtoVRPlayer.h>
#import "PlayerViewController.h"
//#import "PlayerViewWithCustomUIController.h"

@interface TestTableViewController ()
@property (nonatomic,strong) NSString *localPath;
@property (nonatomic,strong) NSString *onlineM3U8;
@property (nonatomic,strong) NSString *onlineMP4;
@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation TestTableViewController

#pragma mark - Getters
-(NSString *)localPath {
    if (_localPath == nil) {
        _localPath = [[NSBundle mainBundle] pathForResource:@"wu" ofType:@"mp4"];
    }
    return _localPath;
}
-(NSString *)onlineM3U8 {
    if (_onlineM3U8 == nil) {
        _onlineM3U8 = @"http://cache.utovr.com/201508270528174780.m3u8";
    }
    return _onlineM3U8;
}

-(NSString*)onlineMP4 {
    if (_onlineMP4 == nil) {
        _onlineMP4 = @"http://cache.utovr.com/201508270529022474.mp4";
    }
    return _onlineMP4;
}

-(NSArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[
                        @{
                            @"title":@"视频播放",
                            @"rows":@[@"播放本地视频",@"在线MP4播放",@"在线M3U8播放",@"多个视频播放"],
                            },
                        @{
                            @"title":@"界面样式",
                            @"rows":@[@"默认",@"无",@"自定义"],
                            }
                        ];
    }
    return _dataSource;
}
#pragma mark - Life cycles

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseIdentifier"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section][@"rows"] count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.dataSource[section][@"title"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataSource[indexPath.section][@"rows"][indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UVPlayerViewStyle style = UVPlayerViewStyleDefault;
    if (indexPath.section == 1 && indexPath.row == 1) {
        style = UVPlayerViewStyleNone;
    }
    NSMutableArray *items = [NSMutableArray array];
    
    if (indexPath.section == 0 && indexPath.item == 1) {
        UVPlayerItem *item = [[UVPlayerItem alloc] initWithPath:self.onlineMP4 type:UVPlayerItemTypeOnline];
        [items addObject:item];
    } else if (indexPath.section == 0 && indexPath.item == 2) {
        //播放一个本地和一个在线视频
        UVPlayerItem *item = [[UVPlayerItem alloc] initWithPath:self.onlineM3U8 type:UVPlayerItemTypeOnline];
        [items addObject:item];
    } else if (indexPath.section == 0 && indexPath.item == 3) {
        //播放一个本地和一个在线视频
        UVPlayerItem *item1 = [[UVPlayerItem alloc] initWithPath:self.localPath type:UVPlayerItemTypeLocalVideo];
        [items addObject:item1];
        UVPlayerItem *item2 = [[UVPlayerItem alloc] initWithPath:self.onlineMP4 type:UVPlayerItemTypeOnline];
        [items addObject:item2];
    } else {
        //播放一个本地视频
        UVPlayerItem *item = [[UVPlayerItem alloc] initWithPath:self.localPath type:UVPlayerItemTypeLocalVideo];
        [items addObject:item];
    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
//        PlayerViewWithCustomUIController * playerVC = [[PlayerViewWithCustomUIController alloc] init];
//        [playerVC.itemsToPlay addObjectsFromArray:items];
//        playerVC.title = [NSString stringWithFormat:@"%@-%@",self.dataSource[indexPath.section][@"title"], self.dataSource[indexPath.section][@"rows"][indexPath.item]];
//        [self.navigationController pushViewController:playerVC animated:YES];
        
    } else {
        
        PlayerViewController *playerVC = [[PlayerViewController alloc] init];
        [playerVC.itemsToPlay addObjectsFromArray:items];
        playerVC.player.viewStyle = style;
        playerVC.title = [NSString stringWithFormat:@"%@-%@",self.dataSource[indexPath.section][@"title"], self.dataSource[indexPath.section][@"rows"][indexPath.item]];
        [self.navigationController pushViewController:playerVC animated:YES];
    }
    
}

@end
