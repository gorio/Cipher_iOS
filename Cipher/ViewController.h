//
//  ViewController.h
//  Cipher
//
//  Created by GORIO Engenharia on 6/26/15.
//  Copyright (c) 2015 Cipher. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
//- (IBAction)buttonLoad:(id)sender;


@end

