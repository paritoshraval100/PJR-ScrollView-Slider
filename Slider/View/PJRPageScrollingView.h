//
//  PJRPageScrollingView.h
//  Slider
//
//  Created by Paritosh Raval on 08/10/14.
//  Copyright (c) 2014 paritosh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PJRTopView.h"


@interface PJRPageScrollingView : UIView <UIGestureRecognizerDelegate,UIScrollViewDelegate>
{

}
@property (nonatomic,strong) UIScrollView *pagingScrollView;
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) NSMutableArray *placeArray;
@property (nonatomic,strong) PJRTopView *topView;
@property BOOL isSwipeUp;
@property (nonatomic,strong) UIPanGestureRecognizer *panGestureScrollVieew;

@property float pageScrollViewHeight;
@property float topViewCenter;


- (id)initWithFrame:(CGRect)frame withNumberOfItems:(NSMutableArray *)numberOfItems;
- (void)upDownButtonPressed:(id)sender;




@end
