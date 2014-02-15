//
//  CWColorWheelView.m
//  colorwheel
//
//  Created by Dan Zimmerman on 12/26/13.
//  Copyright (c) 2013 Dan Zimmerman. All rights reserved.
//

#import "CWColorWheelView.h"
#import "DZMagnifyingView.h"

@implementation CWColorWheelView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.HSBAlpha = 1;
        self.HSBBrightness = 1;
        colorWheelImage = [UIImage imageNamed:@"CWColorWheelImage"];
        
        magnifier = [[DZMagnifyingView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        magnifier.targetView = self;

    }
    return self;
}

- (UIImage *)compositeImage {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef c = UIGraphicsGetCurrentContext();
    // Use existing opacity as is
    // Apply supplied opacity
//    CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeScreen);

    CGContextAddArc(c, self.frame.size.width*0.5, self.frame.size.width*0.5, self.frame.size.width*0.5 - 1, 0, 2*M_PI, 0);
    [[UIColor blackColor] setStroke];
    CGContextSetLineWidth(c, 1);
    CGContextStrokePath(c);

    CGContextAddArc(c, self.frame.size.width*0.5, self.frame.size.width*0.5, self.frame.size.width*0.5-1, 0, 2*M_PI, 0);
    CGContextClip(c);
    
    [colorWheelImage drawInRect:self.bounds blendMode:kCGBlendModeCopy alpha:self.HSBAlpha];
    [[[UIColor blackColor] colorWithAlphaComponent:1 - self.HSBBrightness] set];
    CGContextFillRect(UIGraphicsGetCurrentContext(), self.bounds);
    
    
    compositeWheelImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return compositeWheelImage;
}


- (void)drawRect:(CGRect)rect {
    [[self compositeImage] drawInRect:rect];
}

- (void)setHSBAlpha:(CGFloat)HSBAlpha {
    _HSBAlpha = HSBAlpha;
    [self setNeedsDisplay];
}

- (void)setHSBBrightness:(CGFloat)HSBBrightness {
    _HSBBrightness = HSBBrightness;
    [self setNeedsDisplay];
}

- (void)updateColorForPoint:(CGPoint)ij {
    float radius = floor(MIN(self.frame.size.width/2, self.frame.size.height/2));
    CGPoint middle = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGPoint r = CGPointMake(middle.x - ij.x, middle.y - ij.y);
    CGFloat hue = (atan2(-r.y, r.x) + M_PI) / (2 * M_PI);
    CGFloat sat = sqrt(r.x*r.x + r.y*r.y)/radius;
    if (sat > 1) {
        [magnifier hide];
    } else {
        [magnifier show];
    }
    CGFloat bright = self.HSBBrightness;
    CGFloat alpha = self.HSBAlpha;
    UIColor *col = [UIColor colorWithHue:hue saturation:sat brightness:bright alpha:alpha];
    if (self.colorPickedHandler) {
        self.colorPickedHandler(col);
    }
    magnifier.center = [self convertPoint:CGPointMake(ij.x, ij.y-50) toView:self.window];
    magnifier.closeupCenter = ij;
}

- (void)updateCachedWheel {
    magnifier.targetView = self;
}

- (void)close {
    [magnifier hide];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self updateColorForPoint:[touch locationInView:self]];
    [magnifier show];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self updateColorForPoint:[touch locationInView:self]];
    [magnifier hide];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    [self updateColorForPoint:[touch locationInView:self]];
}

@end
