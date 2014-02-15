//
//  CWColorPickerViewController.m
//  colorwheel
//
//  Created by Dan Zimmerman on 12/26/13.
//  Copyright (c) 2013 Dan Zimmerman. All rights reserved.
//

#import "CWColorPickerViewController.h"

#import "CWColorWheelView.h"

@interface CWColorPickerViewController ()

@end

@implementation CWColorPickerViewController

#pragma mark - UIViewController

- (void)loadView {
    [super loadView];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    colorSwatch = [[UIView alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, 40)];
    colorSwatch.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    colorSwatch.backgroundColor = self.color;
    colorSwatch.layer.borderWidth = 1;
    [self.view addSubview:colorSwatch];
    
    colorWheel = [[CWColorWheelView alloc] initWithFrame:CGRectMake(20, 100, 250, 250)];
    __unsafe_unretained typeof(self) this = self;
    [colorWheel setColorPickedHandler:^(UIColor *color) {
        [this _setColor:color];
    }];
    [self.view addSubview:colorWheel];
    brightnessSlider = [[UISlider alloc] initWithFrame:CGRectMake(CGRectGetMaxX(colorWheel.frame) + 10, CGRectGetMinY(colorWheel.frame), CGRectGetHeight(colorWheel.frame), 20)];
//    brightnessSlider.backgroundColor = [UIColor blackColor];
    brightnessSlider.transform = CGAffineTransformMakeRotation(-M_PI/2);
    brightnessSlider.center = CGPointMake(CGRectGetMaxX(colorWheel.frame) + 10 + brightnessSlider.frame.size.width/2, CGRectGetMinY(colorWheel.frame) + colorWheel.frame.size.height/2);
    [self.view addSubview:brightnessSlider];
    brightnessSlider.continuous = YES;
    brightnessSlider.minimumValue = 0;
    brightnessSlider.maximumValue = 1;
    brightnessSlider.value = colorWheel.HSBBrightness;
    [brightnessSlider addTarget:self action:@selector(brightnessChanged:) forControlEvents:UIControlEventValueChanged];
    [brightnessSlider addTarget:self action:@selector(finishedSliding:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    alphaSlider = [[UISlider alloc] initWithFrame:CGRectMake(colorWheel.frame.origin.x, CGRectGetMaxY(colorWheel.frame) + 30, colorWheel.frame.size.width, 20)];
    alphaSlider.continuous = YES;
    alphaSlider.minimumValue = 0;
    alphaSlider.maximumValue = 1;
    alphaSlider.value = colorWheel.HSBAlpha;
    [alphaSlider addTarget:self action:@selector(alphaChanged:) forControlEvents:UIControlEventValueChanged];
    [alphaSlider addTarget:self action:@selector(finishedSliding:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [self.view addSubview:alphaSlider];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [colorWheel close];
}

- (void)finishedSliding:(UISlider *)slid {
    [colorWheel updateCachedWheel];
}

- (NSString *)title {
    return @"Color Picker";
}

- (void)viewWillAppear:(BOOL)animated {
    if (!self.color) {
        self.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    }
    if (!self.navigationController) {
        [NSException raise:@"CWColorPickerViewController Presentation Exception" format:@"You must present CWColorPickerViewController with a surrounding UINavigationController"];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)done:(id)b {
    [self.delegate colorPicker:self pickedColor:self.color];
}

- (void)brightnessChanged:(UISlider *)slid {
    colorWheel.HSBBrightness = brightnessSlider.value;
    CGFloat hue = 0, sat = 0, bright = 0, alpha = 0;
    [self.color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
    [self _setColor:[UIColor colorWithHue:hue saturation:sat brightness:brightnessSlider.value alpha:alpha]];
}

- (void)alphaChanged:(UISlider *)slid {
    colorWheel.HSBAlpha = alphaSlider.value;
    CGFloat hue = 0, sat = 0, bright = 0, alpha = 0;
    [self.color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
    [self _setColor:[UIColor colorWithHue:hue saturation:sat brightness:bright alpha:alphaSlider.value]];
}

#pragma mark - SetterGetter

- (void)_setColor:(UIColor *)color {
    _color = color;
    colorSwatch.backgroundColor = color;
    [self.delegate colorPicker:self colorChanged:self.color];
}

- (void)setColor:(UIColor *)color {
    CGFloat hue = 0, sat = 0, bright = 0, alpha = 0;
    [color getHue:&hue saturation:&sat brightness:&bright alpha:&alpha];
    if (brightnessSlider.value != bright) {
        brightnessSlider.value = bright;
        colorWheel.HSBBrightness = bright;
    }
    if (alphaSlider.value != alpha) {
        alphaSlider.value = alpha;
        colorWheel.HSBAlpha = alpha;
    }
    [colorWheel updateCachedWheel];
    [self _setColor:color];
}

@end
