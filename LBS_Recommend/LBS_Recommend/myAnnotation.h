//
//  myAnnotation.h
//  LBS_Recommend
//
//  Created by lanyer on 16/9/4.
//  Copyright (c) 2016年 lanyer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface myAnnotation : NSObject<MKAnnotation>
{
    CLLocationCoordinate2D coord;
}

@property(nonatomic,readonly) CLLocationCoordinate2D coord;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,copy) NSString *subtitle;

-(instancetype)initWithCoordinate2D:(CLLocationCoordinate2D) coordinate2D;
@end
