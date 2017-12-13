//
//  ViewController.m
//  ImageKeyboard
//
//  Created by iGold on 9/30/14.
//  Copyright (c) 2014 iGold. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MessageUI/MFMailComposeViewController.h>//mail controller


@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    
    IBOutlet UITableView *mTableView;
    
    MPMoviePlayerController * moviePlayer;
}

@end

@implementation ViewController{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void)viewDidLayoutSubviews
//{
//    [self.view bringSubviewToFront:bannerView];
//}



#pragma mark
#pragma -----


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString * text = @"";
    if (indexPath.row == 0) {
        text = @"Help Tutorial (Video)";
    } else if (indexPath.row == 1) {
        text = @"Quick Setup";
    } else if (indexPath.row == 2) {
        text = @"Feedback";
    } else {
        text = @"Privacy Policy";
    }
    
    cell.textLabel.text = text;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self playVideo];
    }
    else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"gotoTutorial" sender:self];        
    }
  
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (IBAction)onClickInstruction:(id)sender {
    
}

-(void) playVideo
{
    NSString * fileName = @"long_version_extended";
    
    moviePlayer= [[MPMoviePlayerController alloc] initWithContentURL:
                  [NSURL fileURLWithPath: [[NSBundle mainBundle] pathForResource:fileName ofType:@"mov"]]];
    
    
    moviePlayer.controlStyle=MPMovieControlStyleDefault;
    //    moviePlayer.shouldAutoplay=NO;
    [moviePlayer play];
    [self.view addSubview:moviePlayer.view];
    [moviePlayer setFullscreen:YES animated:YES];
}

-(void)videoStarted:(NSNotification *)notification{
    
    
    // Entered Fullscreen code goes here..
//    GHAppDelegate *appDelegate = APPDELEGATE;
//    appDelegate.fullScreenVideoIsPlaying = YES;
    
}
-(void)videoFinished:(NSNotification *)notification{
    
    // Left fullscreen code goes here...
//    GHAppDelegate *appDelegate = APPDELEGATE;
//    appDelegate.fullScreenVideoIsPlaying = NO;
    
    //CODE BELOW FORCES APP BACK TO PORTRAIT ORIENTATION ONCE YOU LEAVE VIDEO.
//    [[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationPortrait animated:NO];
    
    //present/dismiss viewcontroller in order to activate rotating.
    UIViewController *mVC = [[UIViewController alloc] init];
    [self presentViewController:mVC animated:NO completion:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) moviePlayBackDonePressed:(NSNotification*)notification
{

    [moviePlayer stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerDidExitFullscreenNotification object:moviePlayer];
    
    
    if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [moviePlayer.view removeFromSuperview];
    }
    moviePlayer=nil;
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification
{
    [moviePlayer stop];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    
    if ([moviePlayer respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [moviePlayer setFullscreen:NO animated:YES];
        [moviePlayer.view removeFromSuperview];
    }
}




@end
