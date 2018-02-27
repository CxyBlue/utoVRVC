//
//  PlayerViewController.h
//  UtoVRPlayerDemo
//
//  Created by administrator on 12/14/15.
//  Copyright © 2015 xue. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UtoVRPlayer/UtoVRPlayer.h>

@interface PlayerViewController : UIViewController
@property (nonatomic,strong) UVPlayer *player;
@property (nonatomic,strong) NSMutableArray *itemsToPlay;

@end
