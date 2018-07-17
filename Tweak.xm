#import "MediaRemote.h"

@interface SpringBoard : NSObject
-(BOOL)_handlePhysicalButtonEvent:(id)arg1 ;
@end
 
@interface SBMediaController : NSObject
+ (instancetype)sharedInstance;
-(BOOL)_sendMediaCommand:(unsigned)command;
-(float)volume;
@end

typedef NS_ENUM(uint32_t, MRMediaRemoteCommand) {
    MRMediaRemoteCommandPlay,
    MRMediaRemoteCommandPause,
    MRMediaRemoteCommandTogglePlayPause,
    MRMediaRemoteCommandStop,
    MRMediaRemoteCommandNextTrack,
    MRMediaRemoteCommandPreviousTrack,
    MRMediaRemoteCommandAdvanceShuffleMode,
    MRMediaRemoteCommandAdvanceRepeatMode,
    MRMediaRemoteCommandBeginFastForward,
    MRMediaRemoteCommandEndFastForward,
    MRMediaRemoteCommandBeginRewind,
    MRMediaRemoteCommandEndRewind,
    MRMediaRemoteCommandRewind15Seconds,
    MRMediaRemoteCommandFastForward15Seconds,
    MRMediaRemoteCommandRewind30Seconds,
    MRMediaRemoteCommandFastForward30Seconds,
    MRMediaRemoteCommandToggleRecord,
    MRMediaRemoteCommandSkipForward,
    MRMediaRemoteCommandSkipBackward,
    MRMediaRemoteCommandChangePlaybackRate,
    MRMediaRemoteCommandRateTrack,
    MRMediaRemoteCommandLikeTrack,
    MRMediaRemoteCommandDislikeTrack,
    MRMediaRemoteCommandBookmarkTrack,
    MRMediaRemoteCommandSeekToPlaybackPosition,
    MRMediaRemoteCommandChangeRepeatMode,
    MRMediaRemoteCommandChangeShuffleMode,
    MRMediaRemoteCommandEnableLanguageOption,
    MRMediaRemoteCommandDisableLanguageOption
};

BOOL allowForward = NO;
BOOL allowBackward = NO;

%hook SpringBoard

	-(_Bool)_handlePhysicalButtonEvent:(UIPressesEvent *)arg1 
	{ 
		int type = arg1.allPresses.allObjects[0].type; 
		int force = arg1.allPresses.allObjects[0].force; 
		
		if(type == 102 && force == 0) //VOLUME UP
		{
			if (allowForward) {
				//GO FORWARD
				//SBMediaController *mediaControl = [objc_getClass("SBMediaController") sharedInstance];
				//[mediaControl _sendMediaCommand:(MRMediaRemoteCommandNextTrack)];
				MRMediaRemoteSendCommand(kMRNextTrack, nil);
				 
				allowForward = NO;
			}
			else {
				allowBackward = YES;
			}
		} 
		if(type == 103 && force == 0) //VOLUME DOWN
		{
			if (allowBackward) {
				//GO BACKWARD
				//SBMediaController *mediaControl = [objc_getClass("SBMediaController") sharedInstance];
				//[mediaControl _sendMediaCommand:(MRMediaRemoteCommandPreviousTrack)];
				MRMediaRemoteSendCommand(kMRPreviousTrack, nil);
				
				allowBackward = NO;
			}
			else {
				allowForward = YES;
			}
		} 
		
		[NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(allowNothing) userInfo:nil repeats:NO];
			
		return %orig; 
		
	}

	%new
	- (void)allowNothing 
	{
		allowForward = NO;
		allowBackward = NO;
	}
%end



	

