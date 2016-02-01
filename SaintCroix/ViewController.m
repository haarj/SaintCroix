//
//  ViewController.m
//  SaintCroix
//
//  Created by Justin Haar on 12/12/15.
//  Copyright © 2015 Justin Haar. All rights reserved.
//

#import "ViewController.h"
#import "Farm.h"
#import <MapKit/MapKit.h>
#import "CustomPointAnnotation.h"
#import "VideosTV.h"

@interface ViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property NSMutableArray *farms;
@property CLLocationManager *manager;
@property BOOL initial;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"St. Croix";
    [self.navigationController setNavigationBarHidden:YES];


    self.manager = [CLLocationManager new];
    [self.manager requestWhenInUseAuthorization];
    self.manager.delegate = self;
    [self.manager setDesiredAccuracy:kCLLocationAccuracyBest];
    [self.manager startUpdatingLocation];

    self.mapView.delegate = self;
    [self.mapView setMapType:MKMapTypeSatelliteFlyover];

    self.mapView.showsBuildings = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.mapType = MKMapTypeSatelliteFlyover;
    self.mapView.showsUserLocation = YES;
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(17.733975, -64.738197);

    [self.mapView setRegion:MKCoordinateRegionMake(center, MKCoordinateSpanMake(20, 20)) animated:YES];

    self.farms = [Farm getFarms];

    for (Farm *farm in self.farms) {
        CustomPointAnnotation *farmAnnotation = [[CustomPointAnnotation alloc]init];
        farmAnnotation.coordinate = CLLocationCoordinate2DMake(farm.lattitude, farm.longitude);
        farmAnnotation.title = farm.title;
        farmAnnotation.farm = farm;

        [self.mapView addAnnotation:farmAnnotation];
    }

    self.initial = YES;

}

-(void)viewDidAppear:(BOOL)animated
{
    self.mapView.delegate = self;
    [self.mapView setMapType:MKMapTypeSatelliteFlyover];
    [self.navigationController setNavigationBarHidden:YES];


}

-(void)viewDidDisappear:(BOOL)animated
{

}

-(void)viewWillDisappear:(BOOL)animated
{
    self.mapView.delegate = nil;
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)didReceiveMemoryWarning
{
    NSLog(@"there is a memory warning");
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.35, 0.35);
//    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(17.733975, -64.738197);
//    [self.mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];
//    [self.manager stopUpdatingLocation];

}


-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    CustomPointAnnotation *pointAnnotation = (CustomPointAnnotation*)view.annotation;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    VideosTV *videos = [storyboard instantiateViewControllerWithIdentifier:@"videosTV"];
    videos.farm = pointAnnotation.farm;
    [self.navigationController pushViewController:videos animated:YES];



    NSLog(@"%@", pointAnnotation.farm);
}

-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [self.mapView setRegion:MKCoordinateRegionMake([view.annotation coordinate], MKCoordinateSpanMake(0.005, 0.005)) animated:YES];
}

-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    MKCoordinateSpan span = MKCoordinateSpanMake(0.35, 0.35);
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(17.733975, -64.738197);
    [self.mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    CustomPointAnnotation *pointAnnotation = (CustomPointAnnotation*)annotation;

    if ([pointAnnotation isKindOfClass: [MKUserLocation class]]) {
        return nil;
    }else {
        MKPinAnnotationView *pinAnnotation = [[MKPinAnnotationView alloc]initWithAnnotation:pointAnnotation reuseIdentifier:nil];
        pinAnnotation.canShowCallout = YES;
        pinAnnotation.animatesDrop = YES;
        pinAnnotation.pinColor = MKPinAnnotationColorGreen;
        pinAnnotation.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        UIImageView *view = [[UIImageView alloc]initWithImage:pointAnnotation.farm.image];
        [view setFrame:CGRectMake(0, 0, 30, 30)];
        //    [view setImage:pointAnnotation.farm.image];
        pinAnnotation.leftCalloutAccessoryView = view;

        return pinAnnotation;

    }

}

-(void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered
{
    if (self.initial == YES && fullyRendered == YES) {
        MKCoordinateSpan span = MKCoordinateSpanMake(0.35, 0.35);
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake(17.733975, -64.738197);
        [self.mapView setRegion:MKCoordinateRegionMake(center, span) animated:YES];
        [self.manager stopUpdatingLocation];
        self.initial = NO;
    }
}






@end
