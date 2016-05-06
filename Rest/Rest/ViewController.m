//
//  ViewController.m
//  Rest
//
//  Created by Pyunghyuk Yoo on 5/6/16.
//  Copyright © 2016 Pyunghyuk Yoo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)fetchGreeting; {
    NSURL *url = [NSURL URLWithString:@"http://localhost:5000/greeting"];
    [[[NSURLSession sharedSession]
            dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSLog(@"Handle response");
                NSLog(@"data: %@", data);

                if (data.length > 0 && error == nil) {
                    NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                    NSLog(@"greeting-id: %@", greeting[@"id"]);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.greetingId.text = [greeting[@"id"] stringValue];
                        self.greetingContent.text = greeting[@"content"];
                    });
                }
            }] resume];
}

- (IBAction)fetchGreetingWithNSURLRequest; {
    NSURL *url = [NSURL URLWithString:@"http://localhost:5000/greeting"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                   NSData *data, NSError *connectionError) {
                               if (data.length > 0 && connectionError == nil) {
                                   NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                                            options:0
                                                                                              error:NULL];
                                   self.greetingId.text = [[greeting objectForKey:@"id"] stringValue];
                                   self.greetingContent.text = [greeting objectForKey:@"content"];
                               }
                           }];
}

@end
