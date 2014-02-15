//
//  CWColorWheelView.h
//  colorwheel
//
//  Created by Dan Zimmerman on 12/26/13.
//  Copyright (c) 2013 Dan Zimmerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DZMagnifyingView;
@interface CWColorWheelView : UIView {
    UIImage *colorWheelImage;
    UIImage *compositeWheelImage;
    
    DZMagnifyingView *magnifier;
}

@property (nonatomic) CGFloat HSBBrightness;
@property (nonatomic) CGFloat HSBAlpha;

@property (nonatomic, copy) void (^colorPickedHandler)(UIColor *color);

- (void)updateCachedWheel;
- (void)close;

@end
