//
//  ViewController.m
//  LBS_Recommend
//
//  Created by lanyer on 16/9/4.
//  Copyright (c) 2016年 lanyer. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<MKMapViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个MKMapView视图
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:mapView];
    [mapView setDelegate:self];
    
    //地图参数
    [mapView setMapType:MKMapTypeStandard];//地图类型
    
    [mapView setZoomEnabled:YES];//地图缩放
    [mapView setScrollEnabled:YES];//地图移动
    [mapView setRotateEnabled:YES];//地图旋转
    
    //设施地图显示区域 北工大经纬度：116.486297,39.877492 ;北工大东门经纬度: 116.486554,39.891103
    
    //通过缩放比例（跨度）显示区域
    //MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(39.877492, 116.486297), MKCoordinateSpanMake(0.1, 0.1));
    
    //通过距离显示区域，根据距离显示，以中心为基本点，米为单位，半径1000，上下左右则为2000
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(39.877492, 116.486297), 2000, 2000);
    [mapView setRegion:[mapView regionThatFits:region]];//regionThatFits 使得地图更加适合屏幕
    
    //地图标注
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(39.877492, 116.486297);
    CLLocationCoordinate2D coordinate2d = CLLocationCoordinate2DMake(39.891103, 116.486554);
//    CLLocationCoordinate2D  coordinate2D;
//    coordinate2D.latitude = 39.877492;
//    coordinate2D.longitude = 116.486297;
    MKPointAnnotation * pointAnnotation1 = [[MKPointAnnotation alloc]init];
    [pointAnnotation1 setTitle:@"当前位置"];
    [pointAnnotation1 setSubtitle:@"位置说明"];
    [pointAnnotation1 setCoordinate:coordinate2D];
    
    //设置多个大头针
    MKPointAnnotation * pointAnnotation2 = [[MKPointAnnotation alloc]init];
    [pointAnnotation2 setTitle:@"当前位置"];
    [pointAnnotation2 setSubtitle:@"位置说明"];
    [pointAnnotation2 setCoordinate:coordinate2d];
    
    NSArray *pointAnnotations = @[pointAnnotation1,pointAnnotation2];
    [mapView addAnnotations:pointAnnotations];
    [mapView selectAnnotation:pointAnnotation1 animated:YES];//无需点击大头针  就显示气泡 
}

//通过代理设置地图标注（大头针）属性
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //如果创建多个大头针 通过代理进行优化 减少内存占用空间
    static NSString *PID = @"pid";
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:PID];
    if (!pinAnnotationView) {
        pinAnnotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:PID];
        
        [pinAnnotationView setPinColor:MKPinAnnotationColorGreen];//大头针颜色
        [pinAnnotationView setAnimatesDrop:YES];//大头针下落效果
        [pinAnnotationView setCanShowCallout:YES];//设置大头针气泡可以显示
    }
    //MKPinAnnotationView *pinAnnotationView = [[MKPinAnnotationView alloc]init];
   /* [pinAnnotationView setPinColor:MKPinAnnotationColorGreen];//大头针颜色
    [pinAnnotationView setAnimatesDrop:YES];//大头针下落效果
    [pinAnnotationView setCanShowCallout:YES];//设置大头针气泡可以显示
    */
    return pinAnnotationView;
}



#pragma mark MapViewDelegate
//地图显示区域将要发生改变时执行,可用来判断经纬度是否在显示区域内
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"地图区域即将发生改变" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
//    [alertView show];
}
//地图区域发生改变
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"地图区域发生改变" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
//    [alertView show];
}

//地图开始载入执行
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
    
}
//地图载入完成后执行
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
    
}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
    NSLog(@"error is %@",[error description]);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
