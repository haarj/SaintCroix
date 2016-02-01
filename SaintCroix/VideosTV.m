//
//  VideosTV.m
//  SaintCroix
//
//  Created by Justin Haar on 12/13/15.
//  Copyright © 2015 Justin Haar. All rights reserved.
//

#import "VideosTV.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface VideosTV () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation VideosTV

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = [NSString stringWithFormat:@"%@ Videos", self.farm.title];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    NSURL *url = self.farm.videos[indexPath.section];
    NSString *string = [url path];
    NSArray *parts = [string componentsSeparatedByString:@"/"];
    NSString *filename = [parts lastObject];
    cell.textLabel.text = filename;

    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.farm.videos.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSURL *path = self.farm.videos[indexPath.section];

    if ([path.pathExtension isEqual:@"MOV"]) {
        AVPlayerViewController *playerVC = [AVPlayerViewController new];
        AVPlayer *player = [[AVPlayer alloc]initWithURL:path];
        playerVC.showsPlaybackControls = YES;
        playerVC.player = player;
        [self presentViewController:playerVC animated:YES completion:nil];

    }else
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:path];
        UIViewController *controller = [UIViewController new];
        UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.frame];
        webView.scalesPageToFit = YES;
        [webView loadRequest:request];
        [controller.view addSubview:webView];
        NSLog(@"The gestures are, %@", webView.gestureRecognizers);
        [self.navigationController pushViewController:controller animated:YES];
    }
    
}
@end
