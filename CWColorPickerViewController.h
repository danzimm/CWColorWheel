//
//  CWColorPickerViewController.h
//  colorwheel
//
//  Created by Dan Zimmerman on 12/26/13.
//  Copyright (c) 2013 Dan Zimmerman. All rights reserved.
//

/*
 * @zdocs filedescription
 *
 * @title CWColorPickerViewController Class Reference
 *
 * @@ Use this class to display the color wheel. Future versions may support multiple types of color pickers.
 */

#import <UIKit/UIKit.h>

@protocol CWColorPickerViewControllerDelegate;

@class CWColorWheelView;
@interface CWColorPickerViewController : UIViewController {
    CWColorWheelView *colorWheel;
    UISlider *brightnessSlider;
    UISlider *alphaSlider;
    
    UIView *colorSwatch;
}
/*
 * @description The delegate for this color picker.
 *
 * @discussion Set the delegate in order to get events about when a color is picked and when it is changed.
 */
@property (nonatomic) id <CWColorPickerViewControllerDelegate> delegate;
/*
 * @description Set or get the current color for the color picker.
 *
 * @discussion Setting this updates the color picker's UI
 */
@property (nonatomic) UIColor *color;

@end

@protocol CWColorPickerViewControllerDelegate <NSObject>
@required
/*
 * @description The callback when the user taps the 'done' button.
 *
 * @discussion One needs to manually dismiss this viewcontroller, usually after this method is called.
 */
- (void)colorPicker:(CWColorPickerViewController *)cp pickedColor:(UIColor *)color;
/*
 * @description The callback when the user changes the color (when he taps on the color wheel or moves his finger).
 *
 * @discussion This gets called often, so don't do any heavy lifting here!
 */
- (void)colorPicker:(CWColorPickerViewController *)cp colorChanged:(UIColor *)color;

@end
