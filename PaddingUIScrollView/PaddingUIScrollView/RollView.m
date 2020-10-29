//
//  RollView.m
//  QQproject
//
//  Created by 冯高杰 on 2020/10/27.
//

#import "RollView.h"

@interface RollView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) NSArray *rollDataArr;   // 图片数据

@property (nonatomic, assign) float halfGap;   // 图片间距的一半

@end

@implementation RollView

- (instancetype)initWithFrame:(CGRect)frame withDistanceForScroll:(float)distance withGap:(float)gap
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.halfGap = gap / 2;
        
        /** 设置 UIScrollView */
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(distance, 0, self.frame.size.width - 2 * distance, self.frame.size.height)];
        [self addSubview:self.scrollView];
        self.scrollView.pagingEnabled = YES;
        self.scrollView.delegate = self;
        self.scrollView.clipsToBounds = NO;
        s
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        /** 数据初始化 */
        self.rollDataArr = [NSArray array];
        
    }
    return self;
}

#pragma mark - 视图数据
-(void)rollView:(NSArray *)dataArr{

    self.rollDataArr = dataArr;
    //循环创建添加轮播图片, 前后各添加一张
    for (int i = 0; i < self.rollDataArr.count; i++) {
        
        for (UIView *underView in self.scrollView.subviews) {
            
            if (underView.tag == 400 + i) {
                [underView removeFromSuperview];
            }
        }
        
        UIImageView *picImageView = [[UIImageView alloc] init];
        picImageView.userInteractionEnabled = YES;
        picImageView.tag = 400 + i ;
        
        /**  说明
         *   1. 设置完 ScrollView的width, 那么分页的宽也为 width.
         *   2. 图片宽为a 间距为 gap, 那么 图片应该在ScrollView上居中, 距离ScrollView左右间距为halfGap.
         *   与 ScrollView的width关系为 width = halfGap + a + halfGap.
         *   3. distance : Scroll距离 底层视图View两侧距离.
         *   假设 要露出上下页内容大小为 m ,   distance = m + halfGap
         *
         *  图片位置对应关系 :
         *  0 ->  1 * halfGap ;
         *  1 ->  3 * halfGap + a ;
         *  2 ->  5 * halfGap + 2 * a ;
              
                     
         *  i   -> (2 * i +1) *  halfGap + i *(width - 2 * halfGap )
         */
        
        picImageView.frame = CGRectMake((2 * i + 1) * self.halfGap + i * (self.scrollView.frame.size.width - 2 * self.halfGap), 0, (self.scrollView.frame.size.width - 2 * self.halfGap), self.frame.size.height);
        // 设置图片
        picImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", self.rollDataArr[i]]];
        picImageView.transform = CGAffineTransformMakeScale(1, 0.8);

        
        [self.scrollView addSubview:picImageView];
    }
    //设置轮播图当前的显示区域
    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.rollDataArr.count, 0);
    
    UIImageView *imageView = [self viewWithTag:400 + 0];
    imageView.transform = CGAffineTransformMakeScale(1, 1);
    
}

#pragma mark - UIScrollViewDelegate 方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    
    NSInteger curIndex = scrollView.contentOffset.x  / self.scrollView.frame.size.width;
    NSLog(@"curIndex  =%ld",curIndex+ 400);
    if (self.delegate) {
        [self.delegate didSelectPicWithIndexPath:curIndex];
        
    }
    if (curIndex == 0) {
        
        [UIView animateWithDuration:.2 animations:^{
            UIImageView *imageView00 = [self viewWithTag:400];
            imageView00.transform = CGAffineTransformMakeScale(1, 1);
            
            UIImageView *imageView01 = [self viewWithTag:401];
            imageView01.transform = CGAffineTransformMakeScale(1, 0.8);
            
            UIImageView *imageView02 = [self viewWithTag:402];
            imageView02.transform = CGAffineTransformMakeScale(1, 0.8);
        }];
    }else if (curIndex == 1){
        
        [UIView animateWithDuration:.2 animations:^{
            UIImageView *imageView00 = [self viewWithTag:400];
            imageView00.transform = CGAffineTransformMakeScale(1, 0.8);
            
            UIImageView *imageView01 = [self viewWithTag:401];
            imageView01.transform = CGAffineTransformMakeScale(1, 1);
            
            UIImageView *imageView02 = [self viewWithTag:402];
            imageView02.transform = CGAffineTransformMakeScale(1, 0.8);
        }];
    }
    else if (curIndex == 2){
        
        [UIView animateWithDuration:.2 animations:^{
            UIImageView *imageView00 = [self viewWithTag:400];
            imageView00.transform = CGAffineTransformMakeScale(1, 0.8);
            
            UIImageView *imageView01 = [self viewWithTag:401];
            imageView01.transform = CGAffineTransformMakeScale(1, 0.8);
            
            UIImageView *imageView02 = [self viewWithTag:402];
            imageView02.transform = CGAffineTransformMakeScale(1, 1);
        }];
    }
}



@end
