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

@end
