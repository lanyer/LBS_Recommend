//
//  myAnnotation.m
//  LBS_Recommend
//
//  Created by lanyer on 16/9/4.
//  Copyright (c) 2016年 lanyer. All rights reserved.
//

#import "myAnnotation.h"

@implementation myAnnotation
@synthesize coord;
@synthesize title,subtitle;

-(instancetype)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate2D
{
    if (self= [super init]) {
        coord = coordinate2D;
    }
    return self;
}

-(CLLocationCoordinate2D)coordinate
{
    return coord;
}

-(NSString *) title
{
    return title;
}

-(NSString *) subtitle
{
    return subtitle;
}
@end
