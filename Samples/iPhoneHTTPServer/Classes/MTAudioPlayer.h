//
//  MTServerManager.h
//
//  Feel free to copy whatever you want.
//  Based on MMPDeepSleepPreventer by Marco Peluso
//
//  Doesn't work in iOS 5.0 Simulator
//
//  Created by Yoo-Jin Lee on 11/12/11.
//  Copyright (c) 2011 Mokten Pty Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface MTAudioPlayer : NSObject <AVAudioPlayerDelegate> {
    BOOL isInit;
    AVAudioPlayer* player;
}

@property (nonatomic, retain) AVAudioPlayer* player;

- (void) play: (NSString*) path;
- (void) stop;

- (void) playBackgroundAudio;
- (void) setUpAudioSession;

@end
