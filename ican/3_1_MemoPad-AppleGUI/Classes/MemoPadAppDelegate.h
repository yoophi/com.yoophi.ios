//
//  iCan iPhone4 Programming : Project 3 Memo Pad
//
//  MemoPadAppDelegate.h
//  MemoPad
//
//  Created by DongyoonPark on 1/25/11.
//  Copyright Dong Yoon Park | www.cre8ive.kr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface MemoPadAppDelegate : NSObject <UIApplicationDelegate> {
    
	UIWindow *window;
	UINavigationController *navigationController;

	NSString *DBName;
	NSString *DBPath;
	NSMutableArray *DBData;
	
	BOOL isFirstTimeAccess;
	NSInteger currentMemoSQLIndex; // Index number in SQL
	NSInteger currentMemoRowIndex; // Index number in table view row
	
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) NSString *DBName;
@property (nonatomic, retain) NSString *DBPath;
@property (nonatomic, retain) NSMutableArray *DBData;
@property (assign) BOOL isFirstTimeAccess;

@property (nonatomic, assign) NSInteger currentMemoSQLIndex;
@property (nonatomic, assign) NSInteger currentMemoRowIndex;

-(void) checkAndCreateDatabase;
-(void) readMemoFromDatabase;
-(void) deleteMemoFromDatabase;
-(void) writeMemoToDatabaseWithTitle:(NSString*)inputTitle Content:(NSString*)inputContent;
-(void) updateMemoToDatabaseWithTitle:(NSString*)inputTitle Content:(NSString*)inputContent;

@end

