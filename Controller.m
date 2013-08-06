#import "Controller.h"


@implementation Controller

-(void)awakeFromNib{
		
	goodImg = [[NSImage imageNamed:@"space1.png"] retain];
	badImg = [[NSImage imageNamed:@"space2.png"] retain];
	
	_statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength] retain];
    [_statusItem setHighlightMode:YES];
    [_statusItem setEnabled:YES];
    [_statusItem setMenu:menu];
	[_statusItem setTarget:self];
	//[_statusItem setAction:@selector(click)];
	[_statusItem setImage: [NSImage imageNamed:@"plant.png"]];

	request = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString:@"http://uri.cat/online.txt"] 
									cachePolicy: NSURLRequestReloadIgnoringCacheData
								timeoutInterval: 5.0
						  ];
	
	timer = [NSTimer scheduledTimerWithTimeInterval: 6.0 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
	[self refresh];
	[[NSRunLoop currentRunLoop] addTimer: timer forMode:NSEventTrackingRunLoopMode];	
	
}


-(void)refresh{
	NSURLResponse *theResponse = NULL;
	NSError *theError = NULL;
	[NSURLConnection connectionWithRequest: request delegate: self];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{

	if ( [_statusItem image] != badImg ){
		[[NSSound soundNamed:@"lost"] play];
		[_statusItem setImage: badImg];
	}
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection;{

	if ( [_statusItem image] != goodImg ){
		[[NSSound soundNamed:@"gain"] play];
		[_statusItem setImage: goodImg];	
	}
}


- (IBAction)do:(id)sender{
	
	switch ([sender tag]) {
		case 0: //about
			[aboutWin center];
			[aboutWin makeKeyAndOrderFront:self];
			[aboutWin setLevel:NSNormalWindowLevel + 1];
			break;
				
		case 1: //quit
			[NSApp terminate:self];
			break;

		case 5: 
			[self refresh];
			break;

		default:
			break;
	}
}
@end