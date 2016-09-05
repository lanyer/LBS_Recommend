//
//  ViewController.m
//  LBS_Recommend
//
//  Created by lanyer on 16/9/4.
//  Copyright (c) 2016年 lanyer. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property(nonatomic,strong) MKMapView *mapView;
@property(nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic,strong) UITextField *textField;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    [self.mapView setMapType:MKMapTypeStandard];
    //[self.mapView setShowsUserLocation:YES];//位置在地图上可见
    [self.view addSubview:self.mapView];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(40, 30, 200, 30)];
    [self.textField setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.textField];
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(250, 30, 70, 30);
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(PressedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"search" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    //检查定位功能是否开启
    if ([CLLocationManager locationServicesEnabled ])
    {
        if (!self.locationManager)
        {
            self.locationManager = [[CLLocationManager alloc]init];
            [self.locationManager setDelegate:self];
            [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
            [self.locationManager setDistanceFilter:10];
            [self.locationManager startUpdatingLocation];
            
            if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
            {
                [self.locationManager requestWhenInUseAuthorization];
                [self.locationManager requestAlwaysAuthorization];
            }
        }
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"定位服务并未开启" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

//点击button(search)之后执行的方法
-(void)PressedBtn:(id)sender{
    [self.textField resignFirstResponder];
    if (self.textField.text.length == 0) {
        return;
    }
    [self Geocorder:self.textField.text];//地理编码调用 将文本框内容text 给地理编码中的 str
}

#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusDenied:
        {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"您已拒绝定位服务" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
            break;
            
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * location = locations.lastObject;
    [self reverseGeocoder:location];//反地理编码调用
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error = %@",[error description]);
}

#pragma mark CLGeocoder
//反地理编码
-(void)reverseGeocoder:(CLLocation *)currentLocation
{
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
   [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
    {
       if (error || placemarks.count == 0)
       {
           NSLog(@"error=%@",[error description]);
       }
       else
       {
           //通过placemarks 得到当前经纬度等信息
           CLPlacemark *placemark = placemarks.firstObject;
           MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude), MKCoordinateSpanMake(0.1, 0.1));
           [self.mapView setRegion:[self.mapView regionThatFits:coordinateRegion] animated:YES];
           
           MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc]init];
           [pointAnnotation setTitle:placemark.name];
           [pointAnnotation setCoordinate:CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude)];
           [self.mapView addAnnotation:pointAnnotation];
          // NSLog(@"placemark = %@",[[placemark addressDictionary ]objectForKey:@"City"]);
       }
   }];
}

//地理编码
-(void)Geocorder:(NSString *)str
{
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:str completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if (error || placemarks.count == 0)
        {
            NSLog(@"error=%@",[error description]);
        }
        else
        {
            CLPlacemark *placemark = placemarks.firstObject;
            MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude), MKCoordinateSpanMake(0.1, 0.1));
            [self.mapView setRegion:[self.mapView regionThatFits:coordinateRegion] animated:YES];
            
            MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc]init];
            [pointAnnotation setTitle:placemark.name];
            [pointAnnotation setCoordinate:CLLocationCoordinate2DMake(placemark.location.coordinate.latitude, placemark.location.coordinate.longitude)];
            [self.mapView addAnnotation:pointAnnotation];
            // NSLog(@"placemark = %@",[[placemark addressDictionary ]objectForKey:@"City"]);
        }

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
