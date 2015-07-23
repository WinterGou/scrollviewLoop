//
//  ViewController.m
//  UIScrollViewTest01
//
//  Created by goudongqian on 15/7/19.
//  Copyright (c) 2015年 goudongqian. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
{
    NSMutableArray *subViews;
    NSMutableArray *contentViews;
    
    
}
@property (nonatomic, assign) NSInteger activityIndex;
@property (nonatomic, assign) NSInteger offsetx;;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.activityIndex = 0;
    self.offsetx = 0;
    subViews = [[NSMutableArray alloc] init];
    contentViews = [[NSMutableArray alloc] init];
    
    UIView *view1 = [[UIView alloc] initWithFrame:self.myScrollView.bounds];;
    view1.backgroundColor = [UIColor blackColor];
    [subViews addObject:view1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:self.myScrollView.bounds];;
    view2.backgroundColor = [UIColor redColor];
    [subViews addObject:view2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:self.myScrollView.bounds];;
    view3.backgroundColor = [UIColor greenColor];
    [subViews addObject:view3];
    
    UIView *view4 = [[UIView alloc] initWithFrame:self.myScrollView.bounds];;
    view4.backgroundColor = [UIColor blueColor];
    [subViews addObject:view4];
    
    self.myScrollView.delegate = self;
    self.myScrollView.contentSize = CGSizeMake(self.myScrollView.frame.size.width * 3, self.myScrollView.frame.size.height);
    [self reloadSubViews];
}

- (void)reloadSubViews
{
    for (UIView *subview in self.myScrollView.subviews)
    {
        [subview removeFromSuperview];
        [contentViews removeAllObjects];
    }
    for (int i = 0; i < 3; i++)
    {
        [contentViews addObject:[subViews objectAtIndex:[self validIndexValue:_activityIndex - 1 + i]]];
    }
    for (int i = 0; i < 3; i++)
    {
        UIView *view = contentViews[i];
        view.frame = CGRectMake(self.myScrollView.frame.size.width * i, 0, self.myScrollView.frame.size.width, self.myScrollView.frame.size.height);
        [self.myScrollView addSubview:view];
    }
    [self.myScrollView setContentOffset:CGPointMake(self.myScrollView.frame.size.width + self.myScrollView.frame.size.width * _offsetx, 0)];
}

- (NSUInteger)validIndexValue:(NSInteger)value
{
    if (value == -1)
    {
        return subViews.count - 1;
    }
    else if (value == subViews.count)
    {
        return 0;
    }
    return value;
}

- (void)setActivityIndex:(NSInteger)activityIndex
{
    if (_activityIndex != activityIndex)
    {
        _activityIndex = activityIndex;
        [self reloadSubViews];
    }
    NSLog(@"%d",_activityIndex);
}

- (void)setOffsetx:(NSInteger)offsetx
{
    if (_offsetx != offsetx)
    {
        _offsetx = offsetx;
        [self.myScrollView setContentOffset:CGPointMake(self.myScrollView.frame.size.width + self.myScrollView.frame.size.width * _offsetx, 0)];
        if (_offsetx > 0.5)
        {
            _offsetx = _offsetx - 1;
            self.activityIndex = [self validIndexValue:self.activityIndex + 1];
        }
        else if (_offsetx < -0.5)
        {
            _offsetx = _offsetx + 1;
            self.activityIndex = [self validIndexValue:self.activityIndex - 1];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.offsetx = scrollView.contentOffset.x / scrollView.frame.size.width - 1;
}

@end
