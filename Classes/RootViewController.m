//
//  RootViewController.m
//  FontsBook
//
//  Created by Giovambattista Fazioli on 23/02/11.
//  Copyright 2011 Saidmade Srl. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"


@implementation RootViewController

@synthesize fontsFamily;
@synthesize fontsName;
@synthesize filteredListContent;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"Fonts Book";
	self.tableView.rowHeight = 80.0f;
	
	NSArray *sorted = [[UIFont familyNames] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
	
	self.fontsFamily = [[NSArray alloc] initWithArray:sorted];

	self.filteredListContent = [[NSMutableArray alloc] initWithCapacity:[self.fontsFamily count]];

}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	/*
     If the requesting table view is the search display controller's table view, return the count of
     the filtered list, otherwise return the count of the main list.
     */
    if (tableView == self.searchDisplayController.searchResultsTableView) {
		return [filteredListContent count];
	}
    return [fontsFamily count];
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *fontsNameForFamily = nil;
	
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		fontsNameForFamily = [NSArray arrayWithArray:[UIFont fontNamesForFamilyName:[filteredListContent objectAtIndex:section]]];
	} else {
		fontsNameForFamily = [NSArray arrayWithArray:[UIFont fontNamesForFamilyName:[fontsFamily objectAtIndex:section]]];
	}

    return [fontsNameForFamily count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		return [filteredListContent objectAtIndex:section];
	} else {
		return [fontsFamily objectAtIndex:section];
	}
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	NSArray *fontsNameForFamily = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		fontsNameForFamily = [NSArray arrayWithArray:[UIFont fontNamesForFamilyName:[filteredListContent objectAtIndex:indexPath.section]]];
	} else {
		fontsNameForFamily = [NSArray arrayWithArray:[UIFont fontNamesForFamilyName:[fontsFamily objectAtIndex:indexPath.section]]];
	}

	// Configure the cell.	
	cell.textLabel.font = [UIFont fontWithName:[fontsNameForFamily objectAtIndex:indexPath.row] size:24.0f];
    [cell.textLabel setText:[fontsNameForFamily objectAtIndex:indexPath.row]];

    return cell;
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    /*
     Update the filtered array based on the search text and scope.
     */
    
    [self.filteredListContent removeAllObjects]; // First clear the filtered array.
    
    /*
     Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
     */
    for (NSString *fontFamily in fontsFamily) {
        //if ([scope isEqualToString:@"All"] || [product.type isEqualToString:scope]) {
            NSComparisonResult result = [fontFamily compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame) {
                [self.filteredListContent addObject:fontFamily];
            }
        //}
    }
}

#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
	 [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSArray *fontsNameForFamily = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		fontsNameForFamily = [NSArray arrayWithArray:[UIFont fontNamesForFamilyName:[filteredListContent objectAtIndex:indexPath.section]]];
	} else {
		fontsNameForFamily = [NSArray arrayWithArray:[UIFont fontNamesForFamilyName:[fontsFamily objectAtIndex:indexPath.section]]];
	}	
    
	DetailViewController *detailViewController = [[DetailViewController alloc] init];
	detailViewController.title = [fontsNameForFamily objectAtIndex:indexPath.row];
	// ...
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:detailViewController animated:YES];
	detailViewController.label.font = [UIFont fontWithName:[fontsNameForFamily objectAtIndex:indexPath.row] size:24.0f];
	[detailViewController release];	
	 
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

