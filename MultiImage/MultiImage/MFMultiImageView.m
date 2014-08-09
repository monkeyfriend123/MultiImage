//
//  MFMultiImageView.m
//  MultiImage
//
//  Created by js on 8/9/14.
//  Copyright (c) 2014 __MyCompanyName__. All rights reserved.
//

#import "MFMultiImageView.h"
#import "NSTimer+Addition.h"
@interface MFMultiImageView()<UIScrollViewDelegate>

@property (nonatomic, assign) NSUInteger currentPageIndex;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;

@property (nonatomic, weak) IBOutlet UIImageView *currentImageView;
@property (nonatomic, weak) IBOutlet UIImageView *preImageView;
@property (nonatomic, weak) IBOutlet UIImageView *nextImageView;

@property (nonatomic, assign) BOOL willRefresh;

@property (nonatomic, strong) NSTimer *refreshTimer;
@end

@implementation MFMultiImageView


- (instancetype) init
{
    if (self = [super init]) {
        [self setFrame:CGRectMake(0, 0, 320, 130)];
        UIView *subView = [[[NSBundle mainBundle] loadNibNamed:@"MFMultiImageView" owner:self options:nil] objectAtIndex:0];
        [self addSubview:subView];
        [self.scrollView setContentSize:CGSizeMake(320 * 3, 100)];
        
        
        CGRect frame = CGRectZero;
        
        frame = self.preImageView.frame;
        self.preImageView.frame = frame;
        [self.scrollView addSubview:self.preImageView];
        
        
        frame = self.currentImageView.frame;
        frame.origin = CGPointMake(320, 0);
        self.currentImageView.frame = frame;
        [self.scrollView addSubview:self.currentImageView];
        
        
        frame = self.nextImageView.frame;
        frame.origin = CGPointMake(320 * 2, 0);
        self.nextImageView.frame = frame;
        [self.scrollView addSubview:self.nextImageView];
        
        _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setImagePaths:(NSMutableArray *)imagePaths
{
    _imagePaths = imagePaths;
    self.pageControl.numberOfPages = _imagePaths.count;
}
- (void)layoutSubviews{
    [self displayCurrentImageView];
}
- (NSUInteger)nextImageIndexIndex
{
    NSUInteger nextIndex = self.currentPageIndex + 1;
    if (nextIndex >= self.imagePaths.count) {
        nextIndex = 0;
    }
    return nextIndex;
}

- (NSUInteger )preImagePathIndex
{
    NSUInteger preIndex;
    if (self.currentPageIndex == 0) {
        preIndex = self.imagePaths.count -1;
    }
    else
    {
        preIndex = self.currentPageIndex - 1;
    }
    return preIndex;
}

- (void)displayCurrentImageView
{
    self.pageControl.currentPage = self.currentPageIndex;
    //preImageView
    NSString *preImageViewPath = self.imagePaths[[self preImagePathIndex]];
    [self.preImageView setImage:[UIImage imageNamed:preImageViewPath]];
    
    
    //Current ImageView
    NSString *currentImageViewPath = self.imagePaths[self.currentPageIndex];
    [self.currentImageView setImage:[UIImage imageNamed:currentImageViewPath]];
    
    
    NSString *nextImageViewPath = self.imagePaths[[self nextImageIndexIndex]];
    [self.nextImageView setImage:[UIImage imageNamed:nextImageViewPath]];
    
    [self.scrollView setContentOffset:CGPointMake(320, 0)];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollView == scrollView) {
        CGPoint contentOffset = self.scrollView.contentOffset;
        if (!self.willRefresh && contentOffset.x == 320 + 320) {
            self.currentPageIndex = [self nextImageIndexIndex];
            self.willRefresh = YES;
            [self displayCurrentImageView];
        }
        else if (!self.willRefresh && contentOffset.x  == 0)
        {
            self.willRefresh = YES;
            self.currentPageIndex = [self preImagePathIndex];
            [self displayCurrentImageView];
        }
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.refreshTimer pauseTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.willRefresh = NO;
    [self.scrollView setContentOffset:CGPointMake(320, 0)];
    [self.refreshTimer resumeTimer];
    NSLog(@"scrollViewDidEndDecelerating");
}

- (void)refresh
{
    
    self.currentPageIndex = [self nextImageIndexIndex];
    [self displayCurrentImageView];
    NSLog(@"refresh ");
}
@end
