//
//  Farm.m
//  SaintCroix
//
//  Created by Justin Haar on 12/12/15.
//  Copyright © 2015 Justin Haar. All rights reserved.
//

#import "Farm.h"

@implementation Farm

static NSString *const image = @"Triangle";

-(instancetype)initWithDictionary:(NSDictionary*)dict
{
    if (self) {
        self.title = dict[@"title"];
        self.lattitude = [dict[@"lattitude"] doubleValue];
        self.longitude = [dict[@"longitude"] doubleValue];
        self.image = dict[@"image"];
        self.videos = dict[@"videos"];
    }

    return self;
}

+(NSArray*)getArrayofFarmDictionaries
{
    NSString *sejah1=[[NSBundle mainBundle] pathForResource:@"Sejah vid 1" ofType:@"MOV"];
    NSString *sejah2=[[NSBundle mainBundle] pathForResource:@"Sejah vid 2" ofType:@"MOV"];
    NSString *sejah3 = [[NSBundle mainBundle]pathForResource:@"SejahFarms" ofType:@"pdf"];
    NSURL *sejahURL = [NSURL fileURLWithPath:sejah1];
    NSURL *sejahURL2 = [NSURL fileURLWithPath:sejah2];
    NSURL *sejahURL3 = [NSURL fileURLWithPath:sejah3];

    NSString *gls1=[[NSBundle mainBundle] pathForResource:@"GLS vid 1" ofType:@"MOV"];
    NSString *gls2=[[NSBundle mainBundle] pathForResource:@"GLS vid 2" ofType:@"MOV"];
    NSURL *glsURL = [NSURL fileURLWithPath:gls1];
    NSURL *glsURL2 = [NSURL fileURLWithPath:gls2];

    NSString *arthur =[[NSBundle mainBundle] pathForResource:@"Arthur A. Richards vid 1" ofType:@"MOV"];
    NSString *arthur2 = @"https://www.ffa.org/home";
    NSURL *arthurURL = [NSURL fileURLWithPath:arthur];
    NSURL *arthurURL2 = [NSURL URLWithString:arthur2];

    NSString *hydroponic =[[NSBundle mainBundle] pathForResource:@"Hydroponic vid 1" ofType:@"MOV"];
    NSString *hydroponic2 =[[NSBundle mainBundle] pathForResource:@"Hydroponic vid 2" ofType:@"MOV"];
    NSString *hydroponicWord = [[NSBundle mainBundle]pathForResource:@"Tropics" ofType:@"pdf"];
    NSURL *hydroponicURL = [NSURL fileURLWithPath:hydroponic];
    NSURL *hydroponicURL2 = [NSURL fileURLWithPath:hydroponic2];
    NSURL *wordURL = [NSURL fileURLWithPath:hydroponicWord];

    NSString *lagoon =[[NSBundle mainBundle] pathForResource:@"Lagoon vid 1" ofType:@"MOV"];
    NSString *lagoon2 =[[NSBundle mainBundle] pathForResource:@"Lagoon vid 2" ofType:@"MOV"];
    NSString *lagoon3 =[[NSBundle mainBundle] pathForResource:@"Lagoon vid 2" ofType:@"MOV"];

    NSURL *lagoonURL = [NSURL fileURLWithPath:lagoon];
    NSURL *lagoonURL2 = [NSURL fileURLWithPath:lagoon2];
    NSURL *lagoonURL3 = [NSURL fileURLWithPath:lagoon3];



    NSArray *array = [NSArray arrayWithObjects:
                      @{@"title": @"Lagoon Fisherman",
                        @"lattitude": [NSNumber numberWithDouble:17.754769],
                        @"longitude" : [NSNumber numberWithDouble:-64.693677],
                        @"image" : [UIImage imageNamed:@"Triangle"],
                        @"videos": @[lagoonURL, lagoonURL2, lagoonURL3]
                        },
                      @{@"title": @"Tropics Hydroponics LLC",
                        @"lattitude": [NSNumber numberWithDouble:17.748886],
                        @"longitude" : [NSNumber numberWithDouble:-64.774527],
                        @"image" : [UIImage imageNamed:@"Tropics"],
                        @"videos": @[hydroponicURL, hydroponicURL2, wordURL]

                        },
                      @{@"title": @"FFA program: Arthur A. Richards Junior High School",
                        @"lattitude": [NSNumber numberWithDouble:17.692907],
                        @"longitude" : [NSNumber numberWithDouble:-64.880406],
                        @"image" : [UIImage imageNamed:@"Arthur A. Richards pic"],
                        @"videos": @[arthurURL, arthurURL2]

                        },
                      @{@"title": @"GLG Plant and Produce",
                        @"lattitude": [NSNumber numberWithDouble:17.724750],
                        @"longitude" : [NSNumber numberWithDouble:-64.807603],
                        @"image" : [UIImage imageNamed:@"bookshelf"],
                        @"videos": @[glsURL, glsURL2]

                        },
                      @{@"title": @"Sejah Farms",
                        @"lattitude": [NSNumber numberWithDouble:17.736041],
                        @"longitude" : [NSNumber numberWithDouble:-64.803739],
                        @"image" : [UIImage imageNamed:@"Sejah pic 1"],
                        @"videos": @[sejahURL, sejahURL2, sejahURL3]

                        },
                      nil];

    return array;

}

+(NSMutableArray*)getFarms
{
    NSMutableArray *farms = [NSMutableArray new];
    for (NSDictionary *dict in [self getArrayofFarmDictionaries]) {
        Farm *farm = [[Farm alloc]initWithDictionary:dict];

        [farms addObject:farm];

    }

    return farms;
}
@end
