//
//  PJRnfoScrollView.h
//  Slider
//
//  Created by Paritosh Raval on 08/10/14.
//  Copyright (c) 2014 paritosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJRItems.h"
#import "PJRPageScrollingView.h"

@interface PJRInfoScrollView : UIView
{

}

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *titleLbl;
@property (nonatomic,strong) UILabel *descLbl;
@property (nonatomic,strong) UIButton *upButton;
@property (nonatomic,weak) PJRPageScrollingView *target;


- (id)initWithFrame:(CGRect)frame andItems:(PJRItems *)items;



@end
