//
// cocos2d performance particle test
// Based on the test by Valentin Milea
//

#import "cocos2d.h"
#import "AWTextureFilter.h"

Class nextAction();

@interface MainScene : CCScene
{
}

-(NSString*) title;

-(void) doTest;
@end


@interface FullFilter : MainScene
{}
@end
@interface PartialFilter : MainScene
{}
@end
@interface TextShadow : MainScene
{
	CCSprite *label_;
	CCSprite *shadowLa_;
	NSUInteger number_;
}
- (void) setText:(NSString*)text;
@end
