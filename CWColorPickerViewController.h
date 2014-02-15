//
//  CWColorPickerViewController.h
//  colorwheel
//
//  Created by Dan Zimmerman on 12/26/13.
//  Copyright (c) 2013 Dan Zimmerman. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CWColorPickerViewControllerDelegate;

@class CWColorWheelView;
@interface CWColorPickerViewController : UIViewController {
    CWColorWheelView *colorWheel;
    UISlider *brightnessSlider;
    UISlider *alphaSlider;
    
    UIView *colorSwatch;
}

@property (nonatomic) id <CWColorPickerViewControllerDelegate> delegate;
@property (nonatomic) UIColor *color;

@end

@protocol CWColorPickerViewControllerDelegate <NSObject>
@required
- (void)colorPicker:(CWColorPickerViewController *)cp pickedColor:(UIColor *)color;
- (void)colorPicker:(CWColorPickerViewController *)cp colorChanged:(UIColor *)color;

@end
