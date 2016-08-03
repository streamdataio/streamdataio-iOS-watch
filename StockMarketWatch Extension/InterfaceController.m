// Copyright 2016 Streamdata.io
//
//     Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
//     You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
//     Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//     See the License for the specific language governing permissions and
// limitations under the License.
//
//
//  InterfaceController.m
//  StockMarketWatch Extension

#import "InterfaceController.h"
#import "WatchRow.h"

@interface InterfaceController()
{
    NSArray *dataObject;
}

@end

@implementation InterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
}

- (void)willActivate
{
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    // If this device can support a WatchConnectivity session, activate this session.
    if ([WCSession isSupported])
    {
        self.watchSession = [WCSession defaultSession];
        self.watchSession.delegate = self;
        [self.watchSession activateSession];
    }
}

- (void)didDeactivate
{
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

// This method is called when a new notification message is received from the iPhone app via the WatchConnectivity session.
- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary *)message
{
    NSLog(@"Message received");
    
    dataObject = [message objectForKey:@"dataObject"];
    NSLog(@"dataObject = %@", dataObject);
    
    [self setupTable];
}

// This method updates the content of the Watch app table.
- (void)setupTable
{
    NSArray *sortedData = [dataObject sortedArrayUsingComparator:
                ^NSComparisonResult(id obj1, id obj2) {
                    if ([[obj1 objectForKey:@"price"] integerValue] < [[obj2 objectForKey:@"price"] integerValue])
                    {  return NSOrderedDescending; }
                    else if ([[obj1 objectForKey:@"price"] integerValue] > [[obj2 objectForKey:@"price"] integerValue])
                    { return NSOrderedAscending; }
                    else
                    { return NSOrderedSame; }
                }];
    
    [self.watchTableView setNumberOfRows:sortedData.count withRowType:@"WatchRow"];
    
    for (NSInteger i = 0; i < self.watchTableView.numberOfRows; i++)
    {
        WatchRow *row = [self.watchTableView rowControllerAtIndex:i];
        
        [row.rowTitle setText:[[sortedData objectAtIndex:i] objectForKey:@"title"]];
        
        NSString *price = [NSString stringWithFormat:@"%@", [[sortedData objectAtIndex:i] objectForKey:@"price"]];
        [row.rowPrice setText:price];
    }
}

@end
