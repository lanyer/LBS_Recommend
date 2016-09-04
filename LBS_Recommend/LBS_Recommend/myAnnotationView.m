//
//  myAnnotationView.m
//  LBS_Recommend
//
//  Created by lanyer on 16/9/4.
//  Copyright (c) 2016年 lanyer. All rights reserved.
//

#import "myAnnotationView.h"
#import "myAnnotation.h"

@interface myAnnotationView()//创建一个内部类

@property(nonatomic,strong) myAnnotation * MYAnnotation;
@property(nonatomic,strong) UIView *infoView;
@property(nonatomic,strong) UILabel *infoLabel;
@end

@implementation myAnnotationView


-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.MYAnnotation = annotation;
    }
    return self;
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        self.infoView = [[UIView alloc]initWithFrame:CGRectMake(-(150-50)/2, -30, 150, 30)];
        [self.infoView.layer setBorderColor:[UIColor blackColor].CGColor];
        [self.infoView.layer setBorderWidth:1.f];
        [self.infoView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:self.infoView];
        
        self.infoLabel = [[UILabel alloc]initWithFrame:self.infoView.bounds];
        [self.infoLabel setFont:[UIFont systemFontOfSize:12]];
        [self.infoLabel setTextAlignment:NSTextAlignmentCenter];
        [self.infoLabel setText:[NSString stringWithFormat:@"%f,%f",self.MYAnnotation.coordinate.latitude,self.MYAnnotation.coordinate.longitude]];
        
        
        [self.infoView addSubview:self.infoLabel];
    }
    else
    {
        [self.infoView removeFromSuperview];
    }
}
@end
