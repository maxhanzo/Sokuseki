//
//  JourneyDetailsTableViewController.h
//  Sokuseki
//
//  Created by Ticket Services on 26/01/17.
//  Copyright © 2017 UedaSoft IT Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import "Voyage.h"

@interface JourneyDetailsTableViewController : UITableViewController


@property(nonatomic, strong) NSArray *passengersArray;
@property(nonatomic, strong) Voyage *journey;
@property(nonatomic, assign) NSUInteger topMostNumberOfImmigrants;
@property(nonatomic, assign) BOOL desc;

-(NSNumber*) allPassengers;
@end
