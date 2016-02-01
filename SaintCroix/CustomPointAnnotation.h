//
//  CustomPointAnnotation.h
//  SaintCroix
//
//  Created by Justin Haar on 12/12/15.
//  Copyright © 2015 Justin Haar. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "Farm.h"


@interface CustomPointAnnotation : MKPointAnnotation

@property Farm *farm;

@end
