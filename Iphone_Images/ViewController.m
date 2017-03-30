//
//  ViewController.m
//  Iphone_Images
//
//  Created by Trevor MacGregor on 2017-03-27.
//  Copyright © 2017 Trevor MacGregor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //create a new URL with a web address
    NSURL *url = [NSURL URLWithString:@"http://i.imgur.com/zdwdenZ.png"];
    
    //An NSURLSessionConfiguration object defines the behavior and policies to use when making a request with an NSURLSession object. We can set things like the caching policy on this object. The default system values are good for now, so we'll just grab the default configuration.
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //Create an NSURLSession object using our session configuration. Any changes we want to make to our configuration object must be done before this.
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    
    //We create a task that will actually download the image from the server. The session creates and configures the task and the task makes the request. Download tasks retrieve data in the form of a file, and support background downloads and uploads while the app is not running.
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //If there was an error, we want to handle it straight away so we can fix it. Here we're checking if there was an error, logging the description, then returning out of the block since there's no point in continuing.
        if (error) {
            NSLog(@"error: %@", error.localizedDescription);
            return ;
        }
        //The download task downloads the file to the iPhone then lets us know the location of the download using a local URL. In order to access this as a UIImage object, we need to first convert the file's binary into an NSData object, then create a UIImage from that data.
        NSData *data = [NSData dataWithContentsOfURL:location];
        UIImage *image = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
            self.iPhoneImageView.image = image;
        }];
        
    }];
    //A task is created in a suspended state, so we need to resume it. We can also You can also suspend, resume and cancel tasks whenever we want.
    [downloadTask resume];
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
