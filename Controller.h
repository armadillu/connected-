/* Controller */

#import <Cocoa/Cocoa.h>

@interface Controller : NSObject
{
    IBOutlet id menu;
	IBOutlet id aboutWin;
	
	NSStatusItem	*_statusItem;
	NSTimer * timer;
	NSURLRequest * request;
	
	NSImage*	goodImg;
	NSImage*	badImg;
	
}


- (IBAction)do:(id)sender;
@end
