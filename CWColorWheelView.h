//
//  CWColorWheelView.h
//  colorwheel
//
//  Created by Dan Zimmerman on 12/26/13.
//  Copyright (c) 2013 Dan Zimmerman. All rights reserved.
//

/*
 * @zdocs filedescription
 *
 * @title CWColorWheelView Class Reference
 *
 * @@ The view works on an HSB coordinate system, so you need to set the brightness and alpha for full control out of the color you get. Note that the API for this view is unstable thus it is not recommended that you use this class directly. It is suggested that you use the view controller instead.
 */

#import <UIKit/UIKit.h>

@class DZMagnifyingView;
@interface CWColorWheelView : UIView {
    UIImage *colorWheelImage;
    UIImage *compositeWheelImage;
    
    DZMagnifyingView *magnifier;
}

/*
 * @description Set this to change the color wheel's brightness
 */
@property (nonatomic) CGFloat HSBBrightness;
/*
 * @description Set this to change the color wheel's alpha.
 */
@property (nonatomic) CGFloat HSBAlpha;

/*
 * @description The block called when the user taps or moves to a different color.
 */
@property (nonatomic, copy) void (^colorPickedHandler)(UIColor *color);

/*
 * @description Call this once you are done changing `HSBBrightness` and `HSBAlpha`, otherwise the magnifier will be magnifying an old color wheel with different values of `HSBBrightness` and `HSBAlpha`.
 */
- (void)updateCachedWheel;
/*
 * @description Call this when the color wheel is being taken off screen. It forces the magnifier to hide, otherwise it may stay open.
 */
- (void)close;

@end
