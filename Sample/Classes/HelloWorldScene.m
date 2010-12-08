//
// cocos2d performance particle test
// Based on the test by Valentin Milea
//

#import "HelloWorldScene.h"

enum {
	kTagInfoLayer = 1,
	kTagMainLayer = 2,
	kTagParticleSystem = 3,
	kTagLabelAtlas = 4,
};

static int sceneIdx=0;
static NSString *transitions[] = {
	@"FullFilter",
	@"PartialFilter",
	@"TextShadow",	
};

Class nextAction()
{
	
	sceneIdx++;
	sceneIdx = sceneIdx % ( sizeof(transitions) / sizeof(transitions[0]) );
	NSString *r = transitions[sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}

Class backAction()
{
	sceneIdx--;
	int total = ( sizeof(transitions) / sizeof(transitions[0]) );
	if( sceneIdx < 0 )
		sceneIdx += total;	
	
	NSString *r = transitions[sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}

Class restartAction()
{
	NSString *r = transitions[sceneIdx];
	Class c = NSClassFromString(r);
	return c;
}


#pragma mark MainScene

@implementation MainScene

- (id)init
{
	if ((self = [super init]) != nil) {
				
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		
		// Next Prev Test
		CCMenuItemImage *item1 = [CCMenuItemImage itemFromNormalImage:@"b1.png" selectedImage:@"b2.png" target:self selector:@selector(backCallback:)];
		CCMenuItemImage *item2 = [CCMenuItemImage itemFromNormalImage:@"r1.png" selectedImage:@"r2.png" target:self selector:@selector(restartCallback:)];
		CCMenuItemImage *item3 = [CCMenuItemImage itemFromNormalImage:@"f1.png" selectedImage:@"f2.png" target:self selector:@selector(nextCallback:)];
		CCMenu *menu = [CCMenu menuWithItems:item1, item2, item3, nil];
		[menu alignItemsHorizontally];
		menu.position = ccp(s.width/2, 30);
		[self addChild: menu z:1];	
		
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:[self title] fontName:@"Arial" fontSize:40];
		[label setPosition: ccp(s.width/2, s.height-32)];
		
		[self addChild:label z:1];

		
		[self doTest];
	}
	return self;
}

-(NSString*) title
{
	return @"No title";
}

-(void) restartCallback: (id) sender
{
	CCScene *s = [CCScene node];
	id scene = [restartAction() node];
	[s addChild:scene];
	
	[[CCDirector sharedDirector] replaceScene: s];
}

-(void) nextCallback: (id) sender
{
	CCScene *s = [CCScene node];
	id scene = [nextAction() node];
	[s addChild:scene];
	[[CCDirector sharedDirector] replaceScene: s];
}

-(void) backCallback: (id) sender
{
	CCScene *s = [CCScene node];
	id scene = [backAction() node];
	[s addChild:scene];
	
	[[CCDirector sharedDirector] replaceScene: s];
}

-(void) testNCallback:(id) sender
{
	[self restartCallback:sender];
}

-(void) doTest
{
	// override
}

@end

#pragma mark Test 1

@implementation FullFilter

-(NSString*) title
{
	return @"Full gausian blur filter";
}

-(void) doTest
{
	// The texture MUST be RGBA8888
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	//Create mutable texture
	CCTexture2DMutable *mutableTexture = [[[CCTexture2DMutable alloc] initWithImage:[UIImage imageNamed:@"example.png"]] autorelease];
	
	//Copy the mutable texture as non mutable texture
	CCTexture2D *noMutableTexture = [[mutableTexture copyMutable:NO] autorelease];
	
	//Apply blur to the mutable texture
	[AWTextureFilter blur:mutableTexture radius:6];
	
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	//Create sprites to show the textures
	CCSprite *original = [CCSprite spriteWithTexture:noMutableTexture];
	[original setPosition:ccp(winSize.width/2-original.contentSize.width/2-1, winSize.height/2)];
	
	CCSprite *blur = [CCSprite spriteWithTexture:mutableTexture];
	[blur setPosition:ccp(winSize.width/2+blur.contentSize.width/2+1, winSize.height/2)];
	
	[self addChild:original];
	[self addChild:blur];
}

@end

#pragma mark Test 2

@implementation PartialFilter

-(NSString*) title
{
	return @"Partial blur filter";
}

-(void) doTest
{
	[CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
	
	//Create mutable texture
	CCTexture2DMutable *mutableTexture = [[[CCTexture2DMutable alloc] initWithImage:[UIImage imageNamed:@"example2.png"]] autorelease];
	
	//Apply blur to the mutable texture
	[AWTextureFilter blur:mutableTexture radius:8 rect:CGRectMake(20, 40, 200, 260)];
	
	CGSize winSize = [[CCDirector sharedDirector] winSize];
	
	//Create sprites to show the textures
	CCSprite *blur = [CCSprite spriteWithTexture:mutableTexture];
	[blur setPosition:ccp(winSize.width/2, winSize.height/2)];
	
	[self addChild:blur];
}
@end

#pragma mark Test 3
@implementation TextShadow
-(NSString*) title
{
	return @"Text shadow";
}

-(void) doTest
{
	CGSize winSize = [[CCDirector sharedDirector] winSize];

	CCLayerColor *background = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255) width:300 height:50];
	[background setIsRelativeAnchorPoint:YES];
	[background setAnchorPoint:ccp(0.5f, 0.5f)];
	[background setPosition:ccp(winSize.width/2, winSize.height/2)];
		
	//Create sprites to show the textures
	label_ = [CCSprite node];
	[label_ setPosition:ccp(winSize.width/2, winSize.height/2)];
	
	shadowLa_ = [CCSprite node];
	[shadowLa_ setPosition:ccp(winSize.width/2+1, winSize.height/2+1)];
	[shadowLa_ setColor:ccBLACK];
	
	[self addChild:background z:-1];
	[self addChild:shadowLa_ z:0];
	[self addChild:label_ z:1];
	
	number_ = 0;
	[self schedule:@selector(updateLabel:) interval:0.0f];
}

- (void) updateLabel:(ccTime)delta
{
	[self setText:[NSString stringWithFormat:@"N: %d", number_]];
	number_++;
}

- (void) setText:(NSString*)text
{	
	//Create mutable texture
	CCTexture2DMutable *shadowTexture = [[[CCTexture2DMutable alloc] initWithString:text fontName:@"Arial" fontSize:28] autorelease];
	
	//Copy the mutable texture as non mutable texture
	CCTexture2D *labelTexture = [[shadowTexture copyMutable:NO] autorelease];
	
	[label_ setTexture:labelTexture];
	[label_ setTextureRect:CGRectMake(0, 0, shadowTexture.contentSize.width, shadowTexture.contentSize.height)];
	
	//Apply blur to the mutable texture
	[AWTextureFilter blur:shadowTexture radius:4];
	
	[shadowLa_ setTexture:shadowTexture];
	[shadowLa_ setTextureRect:CGRectMake(0, 0, shadowTexture.contentSize.width, shadowTexture.contentSize.height)];
}
@end

