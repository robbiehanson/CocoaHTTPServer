//
//  MTServerManager.h
//
//  Feel free to copy whatever you want.
//  Based on MMPDeepSleepPreventer by Marco Peluso
//
//  Created by Yoo-Jin Lee on 11/12/11.
//  Copyright (c) 2011 Mokten Pty Ltd. All rights reserved.
//

#import "MTAudioPlayer.h"

@implementation MTAudioPlayer
@synthesize player;

- (void) playBackgroundAudio {
    NSString* path = [[NSBundle mainBundle] pathForResource:@"silence" ofType:@"wav"];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: NULL];
    
    [self play:path];
}


- (void)setUpAudioSession
{
	// Initialize audio session
	AudioSessionInitialize
	(
     NULL,	// Use NULL to use the default (main) run loop.
     NULL,	// Use NULL to use the default run loop mode.
     NULL,	// A reference to your interruption listener callback function.
     // See “Responding to Audio Session Interruptions” in Apple's "Audio Session Programming Guide" for a description of how to write
     // and use an interruption callback function.
     NULL	// Data you intend to be passed to your interruption listener callback function when the audio session object invokes it.
     );
	
	// Activate audio session
	OSStatus activationResult = 0;
	activationResult		  = AudioSessionSetActive(true);
	
	if (activationResult)
	{
		NSLog(@"AudioSession is active");
	}
	
	// Set up audio session category to kAudioSessionCategory_MediaPlayback.
	// While playing sounds using this session category at least every 10 seconds, the iPhone doesn't go to sleep.
	UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;	// Defines a new variable of type UInt32 and initializes it with the identifier
    // for the category you want to apply to the audio session.
	AudioSessionSetProperty
	(
     kAudioSessionProperty_AudioCategory,	// The identifier, or key, for the audio session property you want to set.
     sizeof(sessionCategory),				// The size, in bytes, of the property value that you are applying.
     &sessionCategory						// The category you want to apply to the audio session.
     );
	
	// Set up audio session playback mixing behavior.
	// kAudioSessionCategory_MediaPlayback usually prevents playback mixing, so we allow it here. This way, we don't get in the way of other sound playback in an application.
	// This property has a value of false (0) by default. When the audio session category changes, such as during an interruption, the value of this property reverts to false.
	// To regain mixing behavior you must then set this property again.
	
	// Always check to see if setting this property succeeds or fails, and react appropriately; behavior may change in future releases of iPhone OS.
	OSStatus propertySetError = 0;
	UInt32 allowMixing		  = true;
	
	propertySetError = AudioSessionSetProperty
	(
     kAudioSessionProperty_OverrideCategoryMixWithOthers,	// The identifier, or key, for the audio session property you want to set.
     sizeof(allowMixing),									// The size, in bytes, of the property value that you are applying.
     &allowMixing											// The value to apply to the property.
     );
	
	if (propertySetError)
	{
		NSLog(@"Error setting kAudioSessionProperty_OverrideCategoryMixWithOthers: %li", propertySetError);
	}
}

- (void)dealloc {
    [self stop];
}

- (void) play: (NSString*) path {
    
    if (!isInit) {
        isInit = YES;
        [self setUpAudioSession];
    }
    
    [self.player stop];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: path];
    NSError* err = nil;
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL error: &err];
    // error-checking omitted
    self.player = newPlayer; // retain policy
    [self.player prepareToPlay];
    [self.player setDelegate: self];
    
    // plays forever
    self.player.numberOfLoops = -1;
    
    [self.player play];
}

- (void) stop {
    [self.player stop];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player // delegate method
                       successfully:(BOOL)flag {
    NSLog(@"MTAudioPlayer audioPlayerDidFinishPlaying");
}

@end
