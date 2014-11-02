//
//  PJRnfoScrollView.m
//  Slider
//
//  Created by Paritosh Raval on 08/10/14.
//  Copyright (c) 2014 paritosh. All rights reserved.
//

#import "PJRInfoScrollView.h"
#import "UILabel+UILabelDynamicHeight.h"
#define UPBUTTON_HEIGHT 30

@implementation PJRInfoScrollView


- (id)initWithFrame:(CGRect)frame andItems:(PJRItems *)items
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self loadScrollViewForItems:items];
    }
    return self;
}

- (void)loadScrollViewForItems:(PJRItems *)items
{
    float xPadding = 5.0;
    float yPadding = 5.0;
    float vSpacing = 5.0;
    
    _upButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, UPBUTTON_HEIGHT)];
    [_upButton addTarget:self action:@selector(upDownButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _upButton.backgroundColor = [UIColor lightGrayColor];
    [_upButton setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
    [self addSubview:_upButton];
    
    yPadding += UPBUTTON_HEIGHT;
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, yPadding, self.frame.size.width, self.frame.size.height - yPadding)];
    [self addSubview:_scrollView];
    
    yPadding = 3.0;
    
    // Create Title Lable
    _titleLbl = [[UILabel alloc] init];
    _titleLbl.textColor = [UIColor darkGrayColor];
    _titleLbl.numberOfLines = 0;
    _titleLbl.frame = CGRectMake(xPadding, yPadding, _scrollView.frame.size.width - xPadding*2, 0.0);
    _titleLbl.font = [UIFont systemFontOfSize:20];
    _titleLbl.text = items.itemTitle;
    
    CGSize titleSize = [_titleLbl sizeOfMultiLineLabel];
    _titleLbl.frame = CGRectMake(xPadding, yPadding, titleSize.width, titleSize.height);
    [_scrollView addSubview:_titleLbl];
    
    yPadding += titleSize.height + vSpacing;
    
    
    //Create Description Label
    _descLbl = [[UILabel alloc] init];
    _descLbl.textColor = [UIColor grayColor];
    _descLbl.frame = CGRectMake(xPadding, yPadding, _scrollView.frame.size.width - xPadding*2, 0.0);
    _descLbl.numberOfLines = 0;
    _descLbl.font = [UIFont italicSystemFontOfSize:18];
    _descLbl.text = items.itemDesc;
    
    CGSize descSize = [_descLbl sizeOfMultiLineLabel];
    _descLbl.frame = CGRectMake(xPadding, yPadding, descSize.width, descSize.height);
    [_scrollView addSubview:_descLbl];

}

- (void)upDownButtonPressed:(id)sender
{
    [_target upDownButtonPressed:sender];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _scrollView .frame = CGRectMake(0, UPBUTTON_HEIGHT, self.frame.size.width, self.frame.size.height - UPBUTTON_HEIGHT);
    if(_target.isSwipeUp){
        _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width, _descLbl.frame.origin.y + _descLbl.frame.size.height);

    }
    else{
        _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width,150);

    }

}
@end
