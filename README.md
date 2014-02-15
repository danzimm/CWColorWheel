#CWColorWheel
I couldn't find a good color wheel for iOS so I disassembled apple's color wheel and reimplemented it for iOS.

##Documentation

###Tutorial

In order to have a color wheel appear one must initialize `CWColorPickerViewController` and then show it just like you would any other viewcontroller. In order to change the selected color (or set the initial color you set the color property. In order to really use the view controller you need a delegate that responds to `colorPicker:pickedColor:` and `colorPicker:colorChanged:`, whos names explain when they are called. An example is as follows:
```Objective-C
// example in a UIViewController subclass
- (void)showColorPicker {
    CWColorPickerViewController *cont = [[CWColorPickerViewController alloc] init];
    cont.color = [UIColor greenColor];
    cont.delegate = self;
    [self presentViewController:cont animated:YES completion:^{
    }];
}
// this is called when 'done' is pressed
- (void)colorPicker:(CWColorPickerViewController *)cp pickedColor:(UIColor *)color {
    [self pickedColor:color];
    [cp dismissViewControllerAnimated:cp completion:^{
    }];
}
// this methoid is called whenever a color is changed (finger moves)
- (void)colorPicker:(CWColorPickerViewController *)cp colorChanged:(UIColor *)color {
    [self colorChangedForNow:color];
}
```

Pull requests are welcome!

##Example

[Video](http://danzimm.com/colorwheel.mov)

###License: MIT
