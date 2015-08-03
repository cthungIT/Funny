//
//  CropperImageView.m
//  FunnyImage
//
//  Created by admin on 6/4/15.
//  Copyright (c) 2015 HUNGCAO. All rights reserved.
//

#import "CropperImageView.h"
#import "Constants.h"

@interface CropperImageView (){
    //point last touched by user
    CGPoint _lastPoint;
}

@end

@implementation CropperImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

//Touch gesture, get point started touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"\n %s \n",__func__);
    UITouch *touch = [touches anyObject];
    _lastPoint = [touch locationInView:self];
}

//delete a part image with mode kCGBlendModeClear in Context property image
//and drawRect again to create effect delete
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //Get current location touch with move event
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    //draw again image
    UIGraphicsBeginImageContext(self.frame.size);
    NSLog(@"\nFrame: %@",NSStringFromCGRect(self.frame));
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    [self.image drawAtPoint:CGPointMake(0, 0)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x, _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), DEFAULT_WIDTH_LINE );
    
    //Add mode property to draw context image
    if (IS_ERASE) {
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeClear);
    }
    else {
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    }
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    //end
    UIGraphicsEndImageContext();
    
    //Keep last touch point
    _lastPoint = currentPoint;
}

//Nothing to do end touch event
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"\n %s \n",__func__);
}
@end
