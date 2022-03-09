#import "RNJitsiMeetViewManager.h"
#import "RNJitsiMeetView.h"
#import <JitsiMeetSDK/JitsiMeetUserInfo.h>

@implementation RNJitsiMeetViewManager{
    RNJitsiMeetView *jitsiMeetView;
}

RCT_EXPORT_MODULE(RNJitsiMeetView)
RCT_EXPORT_VIEW_PROPERTY(onConferenceJoined, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onConferenceTerminated, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onConferenceWillJoin, RCTBubblingEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onEnteredPip, RCTBubblingEventBlock)

- (UIView *)view
{
  jitsiMeetView = [[RNJitsiMeetView alloc] init];
  jitsiMeetView.delegate = self;
  return jitsiMeetView;
}

RCT_EXPORT_METHOD(initialize)
{
    RCTLogInfo(@"Initialize is deprecated in v2");
}

RCT_EXPORT_METHOD(
  call:(NSString *)urlString
  userInfo:(NSDictionary *)userInfo
  meetOptions:(NSDictionary *)meetOptions
  meetFeatureFlags:(NSDictionary *)meetFeatureFlags
)
{
    RCTLogInfo(@"Load URL %@", urlString);
    JitsiMeetUserInfo * _userInfo = [[JitsiMeetUserInfo alloc] init];
    if (userInfo != NULL) {
      if (userInfo[@"displayName"] != NULL) {
        _userInfo.displayName = userInfo[@"displayName"];
      }
      if (userInfo[@"email"] != NULL) {
        _userInfo.email = userInfo[@"email"];
      }
      if (userInfo[@"avatar"] != NULL) {
        NSURL *url = [NSURL URLWithString:[userInfo[@"avatar"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        _userInfo.avatar = url;
      }
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        JitsiMeetConferenceOptions *options = [JitsiMeetConferenceOptions fromBuilder:^(JitsiMeetConferenceOptionsBuilder *builder) {        
            builder.room = urlString;
            if(meetOptions[@"token"] != NULL)
              builder.token = meetOptions[@"token"];
            if(meetOptions[@"subject"] != NULL)
              builder.subject = meetOptions[@"subject"];
            if(meetOptions[@"videoMuted"] != NULL)
              builder.videoMuted = [[meetOptions objectForKey:@"videoMuted"] boolValue];
            if(meetOptions[@"audioOnly"] != NULL)
              builder.audioOnly = [[meetOptions objectForKey:@"audioOnly"] boolValue];
            if(meetOptions[@"audioMuted"] != NULL)
              builder.audioMuted = [[meetOptions objectForKey:@"audioMuted"] boolValue];

            if(meetFeatureFlags[@"addPeopleEnabled"] != NULL){
                [builder setFeatureFlag:@"add-people.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"addPeopleEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"add-people.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"calendarEnabled"] != NULL){
                [builder setFeatureFlag:@"calendar.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"calendarEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"calendar.enabled" withBoolean:NO];
            }
              
            if(meetFeatureFlags[@"callIntegrationEnabled"] != NULL){
                [builder setFeatureFlag:@"call-integration.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"callIntegrationEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"call-integration.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"chatEnabled"] != NULL){
                [builder setFeatureFlag:@"chat.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"chatEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"chat.enabled" withBoolean:YES];
            }
            if(meetFeatureFlags[@"closeCaptionsEnabled"] != NULL){
                [builder setFeatureFlag:@"close-captions.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"closeCaptionsEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"close-captions.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"inviteEnabled"] != NULL){
                [builder setFeatureFlag:@"invite.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"inviteEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"invite.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"iosRecordingEnabled"] != NULL){
                [builder setFeatureFlag:@"ios-recording.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"iosRecordingEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"ios-recording.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"liveStreamingEnabled"] != NULL){
                [builder setFeatureFlag:@"live-streaming.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"liveStreamingEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"live-streaming.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"meetingNameEnabled"] != NULL){
                [builder setFeatureFlag:@"meeting-name.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"meetingNameEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"meeting-name.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"toolboxEnabled"] != NULL){
                [builder setFeatureFlag:@"toolbox.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"toolboxEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"toolbox.enabled" withBoolean:YES];
            }
            if(meetFeatureFlags[@"toolboxAlwaysVisible"] != NULL){
                [builder setFeatureFlag:@"toolbox.alwaysVisible" withBoolean:[[meetFeatureFlags objectForKey:@"toolboxAlwaysVisible"] boolValue]];
            }else{
                [builder setFeatureFlag:@"toolbox.alwaysVisible" withBoolean:NO];
            }
            if(meetFeatureFlags[@"raiseHandEnabled"] != NULL){
                [builder setFeatureFlag:@"raise-hand.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"raiseHandEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"raise-hand.enabled" withBoolean:YES];
            }
            if(meetFeatureFlags[@"reactionsEnabled"] != NULL){
                [builder setFeatureFlag:@"reactions.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"reactionsEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"reactions.enabled" withBoolean:YES];
            }
            if(meetFeatureFlags[@"kickOutEnabled"] != NULL){
                [builder setFeatureFlag:@"kick-out.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"kickOutEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"kick-out.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"conferenceTimerEnabled"] != NULL){
                [builder setFeatureFlag:@"conference-timer.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"conferenceTimerEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"conference-timer.enabled" withBoolean:YES];
            }
            if(meetFeatureFlags[@"videoShareButtonEnabled"] != NULL){
                [builder setFeatureFlag:@"video-share.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"meetingPasswordEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"video-share.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"meetingPasswordEnabled"] != NULL){
                [builder setFeatureFlag:@"meeting-password.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"meetingPasswordEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"meeting-password.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"pipEnabled"] != NULL){
                [builder setFeatureFlag:@"pip.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"pipEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"pip.enabled" withBoolean:YES];
            }
            if(meetFeatureFlags[@"tileViewEnabled"] != NULL){
                [builder setFeatureFlag:@"tile-view.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"tileViewEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"tile-view.enabled" withBoolean:YES];
            }
            if(meetFeatureFlags[@"welcomePageEnabled"] != NULL){
                [builder setFeatureFlag:@"welcomepage.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"welcomePageEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"welcomepage.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"securityEnabled"] != NULL){
                [builder setFeatureFlag:@"security-options.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"securityEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"security-options.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"serverUrlChangeEnabled"] != NULL){
                [builder setFeatureFlag:@"server-url-change.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"serverUrlChangeEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"server-url-change.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"replaceParticipant"] != NULL){
                [builder setFeatureFlag:@"replace.participant" withBoolean:[[meetFeatureFlags objectForKey:@"replaceParticipant"] boolValue]];
            }else{
                [builder setFeatureFlag:@"replace.participant" withBoolean:NO];
            }
            if(meetFeatureFlags[@"helpEnabled"] != NULL){
                [builder setFeatureFlag:@"help.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"helpEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"help.enabled" withBoolean:NO];
            }
            if(meetFeatureFlags[@"audioOnlyEnabled"] != NULL){
                [builder setFeatureFlag:@"audio-only.enabled" withBoolean:[[meetFeatureFlags objectForKey:@"audioOnlyEnabled"] boolValue]];
            }else{
                [builder setFeatureFlag:@"audio-only.enabled" withBoolean:NO];
            }
            
            builder.userInfo = _userInfo;
        }];
        [jitsiMeetView join:options];
    });
}

RCT_EXPORT_METHOD(audioCall:(NSString *)urlString userInfo:(NSDictionary *)userInfo)
{
    RCTLogInfo(@"Load Audio only URL %@", urlString);
    JitsiMeetUserInfo * _userInfo = [[JitsiMeetUserInfo alloc] init];
    if (userInfo != NULL) {
      if (userInfo[@"displayName"] != NULL) {
        _userInfo.displayName = userInfo[@"displayName"];
      }
      if (userInfo[@"email"] != NULL) {
        _userInfo.email = userInfo[@"email"];
      }
      if (userInfo[@"avatar"] != NULL) {
        NSURL *url = [NSURL URLWithString:[userInfo[@"avatar"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        _userInfo.avatar = url;
      }
    }
    dispatch_sync(dispatch_get_main_queue(), ^{
        JitsiMeetConferenceOptions *options = [JitsiMeetConferenceOptions fromBuilder:^(JitsiMeetConferenceOptionsBuilder *builder) {        
            builder.room = urlString;
            builder.userInfo = _userInfo;
            builder.audioOnly = YES;
        }];
        [jitsiMeetView join:options];
    });
}

RCT_EXPORT_METHOD(endCall)
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        [jitsiMeetView leave];
    });
}

#pragma mark JitsiMeetViewDelegate

- (void)conferenceJoined:(NSDictionary *)data {
    RCTLogInfo(@"Conference joined");
    if (!jitsiMeetView.onConferenceJoined) {
        return;
    }

    jitsiMeetView.onConferenceJoined(data);
}

- (void)conferenceTerminated:(NSDictionary *)data {
    RCTLogInfo(@"Conference terminated");
    if (!jitsiMeetView.onConferenceTerminated) {
        return;
    }

    jitsiMeetView.onConferenceTerminated(data);
}

- (void)conferenceWillJoin:(NSDictionary *)data {
    RCTLogInfo(@"Conference will join");
    if (!jitsiMeetView.onConferenceWillJoin) {
        return;
    }

    jitsiMeetView.onConferenceWillJoin(data);
}

- (void)enterPictureInPicture:(NSDictionary *)data {
    RCTLogInfo(@"Enter Picture in Picture");
    if (!jitsiMeetView.onEnteredPip) {
        return;
    }

    jitsiMeetView.onEnteredPip(data);
}

@end
