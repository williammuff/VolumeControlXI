#line 1 "Tweak.xm"
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


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class SpringBoard; 
static _Bool (*_logos_orig$_ungrouped$SpringBoard$_handlePhysicalButtonEvent$)(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIPressesEvent *); static _Bool _logos_method$_ungrouped$SpringBoard$_handlePhysicalButtonEvent$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL, UIPressesEvent *); static void _logos_method$_ungrouped$SpringBoard$allowNothing(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST, SEL); 

#line 48 "Tweak.xm"



	static _Bool _logos_method$_ungrouped$SpringBoard$_handlePhysicalButtonEvent$(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIPressesEvent * arg1)  { 
		int type = arg1.allPresses.allObjects[0].type; 
		int force = arg1.allPresses.allObjects[0].force; 
		
		if(type == 102 && force == 0) 
		{
			if (allowForward) {
				
				
				
				MRMediaRemoteSendCommand(kMRNextTrack, nil);
				 
				allowForward = NO;
			}
			else {
				allowBackward = YES;
			}
		} 
		if(type == 103 && force == 0) 
		{
			if (allowBackward) {
				
				
				
				MRMediaRemoteSendCommand(kMRPreviousTrack, nil);
				
				allowBackward = NO;
			}
			else {
				allowForward = YES;
			}
		} 
		
		[NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(allowNothing) userInfo:nil repeats:NO];
			
		return _logos_orig$_ungrouped$SpringBoard$_handlePhysicalButtonEvent$(self, _cmd, arg1); 
		
	}

	

	static void _logos_method$_ungrouped$SpringBoard$allowNothing(_LOGOS_SELF_TYPE_NORMAL SpringBoard* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd)  {
		allowForward = NO;
		allowBackward = NO;
	}




	

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$SpringBoard = objc_getClass("SpringBoard"); MSHookMessageEx(_logos_class$_ungrouped$SpringBoard, @selector(_handlePhysicalButtonEvent:), (IMP)&_logos_method$_ungrouped$SpringBoard$_handlePhysicalButtonEvent$, (IMP*)&_logos_orig$_ungrouped$SpringBoard$_handlePhysicalButtonEvent$);{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$SpringBoard, @selector(allowNothing), (IMP)&_logos_method$_ungrouped$SpringBoard$allowNothing, _typeEncoding); }} }
#line 102 "Tweak.xm"
