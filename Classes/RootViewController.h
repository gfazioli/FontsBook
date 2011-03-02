//
//  RootViewController.h
//  FontsBook
//
//  Created by Giovambattista Fazioli on 23/02/11.
//  Copyright 2011 Saidmade Srl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate> {
	NSArray	*fontsFamily;
	NSArray	*fontsName;
	
	NSMutableArray  *filteredListContent;   // The content filtered as a result of a search.
}

@property(nonatomic, retain) NSArray *fontsFamily;
@property(nonatomic, retain) NSArray *fontsName;
@property (nonatomic, retain) NSMutableArray *filteredListContent;

@end
