//
//  PJRPageScrollingView.m
//  Slider
//
//  Created by Paritosh Raval on 08/10/14.
//  Copyright (c) 2014 paritosh. All rights reserved.
//

#import "PJRPageScrollingView.h"
#import "PJRInfoScrollView.h"
#import "PJRTopView.h"


#define PAGECONTROL_HEIGHT 37
#define PAGESCROLLVIEW_HEIGHT 200
#define TOOCH_UP_HEIGHT 150
#define TOPVIEW_HEIGHT 200
#define DOWN_ANIMATION 260


@implementation PJRPageScrollingView

- (id)initWithFrame:(CGRect)frame withNumberOfItems:(NSMutableArray *)numberOfItems
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self loadViewsForItems:numberOfItems];
        self.placeArray = numberOfItems;
        
    }
    return self;
}

- (void)loadViewsForItems:(NSMutableArray *)numberOfItems
{
    
    //Create Page Control
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.size.height - PAGECONTROL_HEIGHT, self.frame.size.width, PAGECONTROL_HEIGHT)];
    _pageControl.backgroundColor = [UIColor lightGrayColor];
    [_pageControl addTarget:self action:@selector(changePage) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
    
    //Create Paging ScrollView
    _pagingScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height - PAGESCROLLVIEW_HEIGHT-PAGECONTROL_HEIGHT , self.frame.size.width, PAGESCROLLVIEW_HEIGHT)];
    _pagingScrollView.delegate = self;
    _pagingScrollView.scrollEnabled = NO;
    [self addSubview:_pagingScrollView];
    
    //Create TopView
    PJRItems *item = [numberOfItems objectAtIndex:0];

    _topView = [[PJRTopView alloc] initWithFrame:CGRectMake(20, _pagingScrollView.frame.origin.y - TOPVIEW_HEIGHT, self.frame.size.width - 40, TOPVIEW_HEIGHT) andImageName:item.itemImage];

    [self addSubview:_topView];
    _topViewCenter =  _topView.center.y;
    [self sendSubviewToBack:_topView];
    
    
    NSInteger itemsCount = [numberOfItems count];
    
    for (int i = 0 ; i < itemsCount ;i++)
    {
        PJRItems *item = [numberOfItems objectAtIndex:i];
        
        CGRect frame;
        frame.origin.x = _pagingScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = _pagingScrollView.frame.size;

        PJRInfoScrollView *infoScrollView = [[PJRInfoScrollView alloc] initWithFrame:frame andItems:item];
        infoScrollView.target = self;
        
        _panGestureScrollVieew = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
        [_panGestureScrollVieew setMaximumNumberOfTouches:1];
        [_panGestureScrollVieew setDelegate:self];
        [_panGestureScrollVieew setEnabled:YES];
        [infoScrollView addGestureRecognizer:_panGestureScrollVieew];
        [_pagingScrollView addSubview:infoScrollView];

    }
    
    _pagingScrollView.pagingEnabled = NO;
    _pagingScrollView.alwaysBounceVertical = NO;
    _pagingScrollView.alwaysBounceHorizontal = NO;
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveHorizontally:)];
    [panGesture setMaximumNumberOfTouches:1];
    [panGesture setDelegate:self];
    [panGesture setEnabled:YES];
    [self addGestureRecognizer:panGesture];
    
    
    _pagingScrollView.contentSize = CGSizeMake(_pagingScrollView.frame.size.width * itemsCount, _pagingScrollView.frame.size.height-100);

    _pageControl.numberOfPages = itemsCount;
}

#pragma mark - Page Controller Button Method

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    [self viewAnimationsAtIndex:_pageControl.currentPage];
    
}

#pragma mark - Gestures Methods

- (void)move:(UIPanGestureRecognizer *)gestureRecognizer
{
    NSLog(@"y and height is : ");
   
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            NSLog(@"UIGestureRecognizerStateEnded");
            CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
            
            BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
            CGRect rect = _pagingScrollView.frame;
            PJRInfoScrollView *infoScrollView = (PJRInfoScrollView *)gestureRecognizer.view;

            if (isVerticalGesture) {
                if (velocity.y > 0) {
                    if(rect.size.height != PAGESCROLLVIEW_HEIGHT){
                    _isSwipeUp = NO;
                    }
                } else {
                    if(rect.size.height == PAGESCROLLVIEW_HEIGHT){
                        _isSwipeUp = YES;
                    }
                    
                }
                [self verticalScrollAnimation:infoScrollView];
                return;
        }
        
        else {
            _panGestureScrollVieew = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
            [_panGestureScrollVieew setMaximumNumberOfTouches:1];
            [_panGestureScrollVieew setDelegate:self];
            [_panGestureScrollVieew setEnabled:YES];
            [infoScrollView addGestureRecognizer:_panGestureScrollVieew];
            [self moveHorizontally:gestureRecognizer];

        }
        
    }
   
}
- (void)moveHorizontally:(UIPanGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateEnded");
        CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
        
        BOOL isVerticalGesture = fabs(velocity.y) > fabs(velocity.x);
        NSInteger val = 0;
        CGRect rect = _pagingScrollView.frame;
        
        if (isVerticalGesture) {
            return;
        }
        else{
            if(rect.size.height != PAGESCROLLVIEW_HEIGHT){
                return;
            }
            
            if (velocity.x > 0) {
                val = _pageControl.currentPage - 1;
            } else {
                val = _pageControl.currentPage + 1;
            }
        }
        
        [self viewAnimationsAtIndex:val];
    }
}

- (void) viewAnimationsAtIndex:(NSInteger)index
{
    //Do Whatever You want on End of Gesture
    CGRect frame;
    frame.origin.x = _pagingScrollView.frame.size.width * (index);
    frame.origin.y = 0;
    frame.size = _pagingScrollView.frame.size;
    [_pagingScrollView scrollRectToVisible:frame animated:YES];
    _pagingScrollView.backgroundColor = [UIColor whiteColor];
    
    UIView *view = _topView;
    CGPoint originalCenter = view.center;
    if(view.center.y != _topViewCenter){
        return;
    }
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGPoint center = view.center;
                         center.y += DOWN_ANIMATION;
                         view.center = center;
                     }
                     completion:^(BOOL finished){
                         
                         if(index >= 0 && index < [_placeArray count]){
                             PJRItems *item = [_placeArray objectAtIndex:index];
                             
                             [_topView.imgView setImage:[UIImage imageNamed:item.itemImage]];
                         }
                         
                         [UIView animateWithDuration:0.2
                                          animations:^{
                                              view.center = originalCenter;
                                          }
                                          completion:^(BOOL finished){
                                              
                                              ;
                                          }];
                         
                     }];
    

}
- (void) verticalScrollAnimation:(PJRInfoScrollView *)infoScrollView
{
    CGRect rect = _pagingScrollView.frame;
    
    if (!_isSwipeUp) {
        if(rect.size.height != PAGESCROLLVIEW_HEIGHT){
            rect.origin.y += TOOCH_UP_HEIGHT;
            rect.size.height-=TOOCH_UP_HEIGHT+PAGECONTROL_HEIGHT;
            [infoScrollView.upButton setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
            
        }
    } else {
        if(rect.size.height == PAGESCROLLVIEW_HEIGHT){
            rect.origin.y -= TOOCH_UP_HEIGHT;
            rect.size.height+=TOOCH_UP_HEIGHT+PAGECONTROL_HEIGHT;
            [infoScrollView.upButton setImage:[UIImage imageNamed:@"down.png"] forState:UIControlStateNormal];

        }
    }
    
    
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         [_pagingScrollView setFrame:rect];
                         CGRect infoFrame = infoScrollView.frame;
                         infoFrame.size.height = rect.size.height;
                         [infoScrollView setFrame:infoFrame];
                         
                     }
                     completion:^(BOOL finished){
                         if(_isSwipeUp){
                             [infoScrollView removeGestureRecognizer:_panGestureScrollVieew];
                             
                         }
                         else{
                             [infoScrollView addGestureRecognizer:_panGestureScrollVieew];
                             
                         }
                         
                     }];
    
    
}


- (void)upDownButtonPressed:(id)sender
{
    PJRInfoScrollView *infoScrollView = (PJRInfoScrollView *)[sender superview];
    _isSwipeUp = !_isSwipeUp;
    [self verticalScrollAnimation:infoScrollView];
    
}


#pragma mark - UIScrollView Delegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = _pagingScrollView.frame.size.width;
    int page = floor((_pagingScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
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
