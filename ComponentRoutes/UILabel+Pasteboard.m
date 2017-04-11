//
//  UILabel+Pasteboard.m
//  ComponentRoutes
//
//  Created by Jion on 2017/4/11.
//  Copyright © 2017年 Youjuke. All rights reserved.
//

#import "UILabel+Pasteboard.h"

@implementation UILabel (Pasteboard)
//UILabel默认是不接收事件的，我们需要自己添加touch事件
-(void)pasteboardHandler {
    
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:longPress];
}

-(void)handleTap:(UIGestureRecognizer*) recognizer {
    if (recognizer.state == UIGestureRecognizerStateBegan){
        [self becomeFirstResponder];
        //UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制"action:@selector(copy:)];
       // [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated: YES];
    }
    
}


- (BOOL)canBecomeFirstResponder{
    
    return YES;
    
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    if (action ==@selector(copy:)){
        return YES;
    }else if (action ==@selector(paste:)){
        return YES;
    }else if (action ==@selector(cut:)){
        return NO;
    }else if(action ==@selector(select:)){
        return NO;
    }else if (action ==@selector(delete:)){
        return NO;
    }

    return NO;
    
}
-(void)copy:(id)sender{
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    
    pboard.string = self.text;
    
}


- (void)paste:(id)sender{
    
    UIPasteboard *pboard = [UIPasteboard generalPasteboard];
    
    self.text = pboard.string;
    
}



@end
