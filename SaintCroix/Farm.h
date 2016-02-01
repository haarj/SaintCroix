//
//  Farm.h
//  SaintCroix
//
//  Created by Justin Haar on 12/12/15.
//  Copyright © 2015 Justin Haar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface Farm : NSObject

@property NSString *title;
@property double lattitude;
@property double longitude;
@property UIImage *image;
@property NSMutableArray *videos;


+(NSMutableArray*)getFarms;

@end
