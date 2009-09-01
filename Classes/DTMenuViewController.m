//
//  DTMenuViewController.m
//  DTMusicModel
//
//  Created by Daniel Tull on 31.08.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTMenuViewController.h"
#import "DTLicenseAgreementViewController.h"
#import "DTArtistsViewController.h"
#import "DTAlbumsViewController.h"
#import "DTSongsViewController.h"
#import "DTGenresViewController.h"

@implementation DTMenuViewController

- (id)init{
    if (!(self = [super initWithStyle:UITableViewStylePlain])) return nil;
	
	items = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MusicMenu" ofType:@"plist"]] retain];
	
	musicModelController = [[DTMusicModelController alloc] init];
	
	self.title = @"DTMusicModel";
	
    return self;
}

- (void)dealloc {
	[musicModelController release];
	[items release];
    [super dealloc];
}

#pragma mark UITableViewDataSource/Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return nil;
	if (section == 0)
		return @"Legal Stuff";
	else
		return @"Music";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
	if (section == 1)
		return nil;
	else
		return @"©2009 Daniel Tull danieltull.co.uk";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0)
		return 1;
	else
		return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    
	if (indexPath.section == 0)
		cell.textLabel.text = @"License Agreement";
	else
		cell.textLabel.text = [items objectAtIndex:indexPath.row];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *cellTitle = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
	
	if (indexPath.section == 0) {
		DTLicenseAgreementViewController *lvc = [[DTLicenseAgreementViewController alloc] init];
		[self.navigationController pushViewController:lvc animated:YES];
		[lvc release];
		return;
	} else if ([cellTitle isEqualToString:@"Artists"]) {
		DTArtistsViewController *avc = [[DTArtistsViewController alloc] initWithItems:[musicModelController allArtists]];
		[self.navigationController pushViewController:avc animated:YES];
		[avc release];
	} else if ([cellTitle isEqualToString:@"Albums"]) {
		DTAlbumsViewController *avc = [[DTAlbumsViewController alloc] initWithItems:[musicModelController allAlbums]];
		[self.navigationController pushViewController:avc animated:YES];
		[avc release];
	} else if ([cellTitle isEqualToString:@"Playlists"]) {
		DTArtistsViewController *avc = [[DTArtistsViewController alloc] initWithItems:[musicModelController allArtists]];
		[self.navigationController pushViewController:avc animated:YES];
		[avc release];
	} else if ([cellTitle isEqualToString:@"Genres"]) {
		DTGenresViewController *gvc = [[DTGenresViewController alloc] initWithItems:[musicModelController allArtists]];
		[self.navigationController pushViewController:gvc animated:YES];
		[gvc release];
	} else if ([cellTitle isEqualToString:@"Songs"]) {
		DTSongsViewController *svc = [[DTSongsViewController alloc] initWithItems:[musicModelController allSongs]];
		[self.navigationController pushViewController:svc animated:YES];
		[svc release];
	}
	
	
}

@end

