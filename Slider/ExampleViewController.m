//
//  ExampleViewController.m
//  Slider
//
//  Created by Paritosh Raval on 07/10/14.
//  Copyright (c) 2014 paritosh. All rights reserved.
//

#import "ExampleViewController.h"
#import "PJRPageScrollingView.h"
#import "PJRItems.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // Do any additional setup after loading the view from its nib.
    
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"Places" ofType:@"plist"];
    
    NSMutableArray *placeArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i =0 ; i < [placeArray count] ; i++){
        
        NSDictionary *dict = [placeArray objectAtIndex:i];
        PJRItems *item = [[PJRItems alloc] init];
        item.itemTitle = [dict objectForKey:@"placeName"];
        item.itemDesc = [dict objectForKey:@"placeDesc"];
        item.itemImage = [dict objectForKey:@"placeImage"];
        [array addObject:item];
    }
    
    PJRPageScrollingView *pagScrollView = [[PJRPageScrollingView alloc] initWithFrame:self.view.bounds withNumberOfItems:array];
    [self.view addSubview:pagScrollView];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
