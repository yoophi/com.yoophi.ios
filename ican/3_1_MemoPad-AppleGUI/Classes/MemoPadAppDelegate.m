//
//  iCan iPhone4 Programming : Project 3 Memo Pad
//
//  MemoPadAppDelegate.m
//  MemoPad
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import "MemoPadAppDelegate.h"
#import "RootViewController.h"
#import "MemoData.h"


@implementation MemoPadAppDelegate



@synthesize window;
@synthesize navigationController;
@synthesize DBName;
@synthesize DBPath;
@synthesize DBData;
@synthesize isFirstTimeAccess;
@synthesize currentMemoSQLIndex;
@synthesize currentMemoRowIndex;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	self.isFirstTimeAccess = TRUE;
	
	// Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	self.DBName = @"MemoPad.db";
	self.DBPath = [documentsDir stringByAppendingPathComponent:self.DBName];

	
	[self checkAndCreateDatabase];


	[window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
	return YES;
}

-(void) checkAndCreateDatabase{

	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required	
	NSFileManager *fileManager = [NSFileManager defaultManager];

	// Check if the database has already been created in the users filesystem	
	// If the database already exists then return without doing anything
	if([fileManager fileExistsAtPath:self.DBPath]) 
	{
		return;
	}
	else 
	{
		NSString *databasePathFromApp = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:self.DBName];

		// Copy the database from the package to the users filesystem	
		[fileManager copyItemAtPath:databasePathFromApp toPath:self.DBPath error:nil];
		[fileManager release];
	}
}

-(void) readMemoFromDatabase {

	sqlite3 *database;

	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}

	// Open the database from the users filessytem
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "SELECT * FROM tblMemoPad ORDER BY MP_Index DESC";
		sqlite3_stmt *compiledStatement;

		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {

			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				
				NSInteger aIndex = sqlite3_column_int(compiledStatement, 0);
				NSString *aTitle = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *aContent = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *aDate = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				
				NSLog(@"%d / %@ / %@ / %@",aIndex,aTitle,aContent,aDate);
				
				MemoData *md = [[MemoData alloc] initWithData:aIndex Title:aTitle Content:aContent Date:aDate];
				
				
				
				// Add the BatteryInsightDB object to the DBData Array
				[self.DBData addObject:md];
				
				[md release];
			}
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
		}

		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
	
}

-(void) writeMemoToDatabaseWithTitle:(NSString*)inputTitle Content:(NSString*)inputContent {
	
	sqlite3 *database;
	
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		//INSERT INTO tblMemoPad(MP_Title, MP_Content, MP_Date) VALUES('Sample data 1','Hello! This is a sample content 1','2010-01-01 00:00:00');

		const char *sqlStatement = "INSERT INTO tblMemoPad(MP_Title, MP_Content, MP_Date) VALUES(?,?,?)";
		sqlite3_stmt *compiledStatement;

		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
				
			
			// For Datetime
			NSDate *date = [NSDate date];
			NSCalendar *calendar = [NSCalendar currentCalendar];
			
			NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;		
			NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
			
			NSString *yearOfCommonEra = [NSString stringWithFormat:@"%02d", [comp year]];
			NSString *monthOfYear = [NSString stringWithFormat:@"%02d", [comp month]];
			NSString *dayOfMonth = [NSString stringWithFormat:@"%02d", [comp day]];
			NSString *hourOfDay = [NSString stringWithFormat:@"%02d", [comp hour]];
			NSString *minuteOfHour = [NSString stringWithFormat:@"%02d", [comp minute]];
			NSString *secondOfMinute = [NSString stringWithFormat:@"%02d", [comp second]];
			
			NSString *dateStringConcat = [NSString stringWithFormat:@"%@-%@-%@",yearOfCommonEra, monthOfYear, dayOfMonth];
			NSString *timeStringConcat = [NSString stringWithFormat:@"%@:%@:%@",hourOfDay, minuteOfHour, secondOfMinute];
			NSString *dateTimeString = [NSString stringWithFormat:@"%@ %@", dateStringConcat, timeStringConcat];
			
			
			sqlite3_bind_text(compiledStatement, 1, [inputTitle UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 2, [inputContent UTF8String] , -1, SQLITE_TRANSIENT);	
			sqlite3_bind_text(compiledStatement, 3, [dateTimeString UTF8String], -1, SQLITE_TRANSIENT);
			
			
			if(SQLITE_DONE != sqlite3_step(compiledStatement))
				NSAssert1(0, @"Error while inserting into tblLocationHistory. '%s'", sqlite3_errmsg(database));
			
			sqlite3_reset(compiledStatement);
			sqlite3_close(database);
			
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 

		}
	}
	else
	{
		sqlite3_close(database);
		
		NSAssert1(0, @"Error opening database in tblLocationHistory. '%s'", sqlite3_errmsg(database));
	}
	
	
}

-(void) updateMemoToDatabaseWithTitle:(NSString*)inputTitle Content:(NSString*)inputContent
{
	
	sqlite3 *database;
	
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {

		NSString* sqlStatementNS = [[NSString alloc] initWithString:[NSString stringWithFormat:@"UPDATE tblMemoPad SET MP_Title=?, MP_Content=?, MP_Date=? WHERE MP_Index = '%d'", self.currentMemoSQLIndex]];
		NSLog(@"SQL = %@", sqlStatementNS);
		const char *sqlStatement = [sqlStatementNS UTF8String];
		
		sqlite3_stmt *compiledStatement;
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			
			
			// For Datetime
			NSDate *date = [NSDate date];
			NSCalendar *calendar = [NSCalendar currentCalendar];
			
			NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;		
			NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
			
			NSString *yearOfCommonEra = [NSString stringWithFormat:@"%02d", [comp year]];
			NSString *monthOfYear = [NSString stringWithFormat:@"%02d", [comp month]];
			NSString *dayOfMonth = [NSString stringWithFormat:@"%02d", [comp day]];
			NSString *hourOfDay = [NSString stringWithFormat:@"%02d", [comp hour]];
			NSString *minuteOfHour = [NSString stringWithFormat:@"%02d", [comp minute]];
			NSString *secondOfMinute = [NSString stringWithFormat:@"%02d", [comp second]];
			
			NSString *dateStringConcat = [NSString stringWithFormat:@"%@-%@-%@",yearOfCommonEra, monthOfYear, dayOfMonth];
			NSString *timeStringConcat = [NSString stringWithFormat:@"%@:%@:%@",hourOfDay, minuteOfHour, secondOfMinute];
			NSString *dateTimeString = [NSString stringWithFormat:@"%@ %@", dateStringConcat, timeStringConcat];
			
			
			sqlite3_bind_text(compiledStatement, 1, [inputTitle UTF8String], -1, SQLITE_TRANSIENT);
			sqlite3_bind_text(compiledStatement, 2, [inputContent UTF8String] , -1, SQLITE_TRANSIENT);	
			sqlite3_bind_text(compiledStatement, 3, [dateTimeString UTF8String], -1, SQLITE_TRANSIENT);
			
			
			if(SQLITE_DONE != sqlite3_step(compiledStatement))
				NSAssert1(0, @"Error while inserting into tblLocationHistory. '%s'", sqlite3_errmsg(database));
			
			sqlite3_reset(compiledStatement);
			sqlite3_close(database);
			
		}
		else {
			printf( "could not prepare statemnt: %s\n", sqlite3_errmsg(database) ); 
			
		}
	}
	else
	{
		sqlite3_close(database);
		
		NSAssert1(0, @"Error opening database in tblLocationHistory. '%s'", sqlite3_errmsg(database));
	}
	
	
}

-(void) deleteMemoFromDatabase
{
	sqlite3 *database;
	
	// Init the DBData Array
	if(self.isFirstTimeAccess == TRUE)
	{
		self.DBData = [[NSMutableArray alloc] init];
		self.isFirstTimeAccess = FALSE;
	}
	else
	{
		[self.DBData removeAllObjects];
	}
	
	// Open the database from the users filessytem
	if(sqlite3_open([self.DBPath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		NSString* sqlStatementNS = [[NSString alloc] initWithString:[NSString stringWithFormat:@"DELETE FROM tblMemoPad WHERE MP_Index = '%d'", self.currentMemoSQLIndex]];
		const char *sqlStatement = [sqlStatementNS UTF8String];
		sqlite3_stmt *compiledStatement;		
		
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			
			if(SQLITE_DONE != sqlite3_step(compiledStatement))
				NSAssert1(0, @"Error while inserting into tblLocationHistory. '%s'", sqlite3_errmsg(database));
			
			sqlite3_reset(compiledStatement);
			
			
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
		[sqlStatementNS release];
		
	}
	sqlite3_close(database);
	
	
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}






#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

