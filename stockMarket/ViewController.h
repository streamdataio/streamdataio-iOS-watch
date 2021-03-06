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
//  ViewController.h
//  stockMarket

#import <UIKit/UIKit.h>
#import "TRVSEventSourceDelegate.h"
#import <WatchConnectivity/WatchConnectivity.h>

// the view controller implements EventSourceDelegate
@interface ViewController : UIViewController <TRVSEventSourceDelegate, UITableViewDataSource, WCSessionDelegate>
{
	// the tableView object to display
    IBOutlet UITableView *tableView;

    // Json object as an Array
    NSMutableArray *dataObject;

    // Server Sent Event Client
    TRVSEventSource *event;

    // The URL to request
    NSURL *URL;
}

// The WatchConnectivity session for communicating with the Watch app
@property (nonatomic) WCSession* watchSession;

@end
