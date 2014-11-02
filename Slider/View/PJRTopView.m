//
//  PJRTopView.m
//  Slider
//
//  Created by Paritosh Raval on 09/10/14.
//  Copyright (c) 2014 paritosh. All rights reserved.
//

#import "PJRTopView.h"

@implementation PJRTopView

- (id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height)];
        [_imgView setImage:[UIImage imageNamed:imageName]];
        [self addSubview:_imgView];
    
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
