//
//  AppSeekBar.m
//  AFNetworking
//
//

#import "AppSeekBar.h"

@interface AppSeekBar ()

@end

@implementation AppSeekBar

WX_PlUGIN_EXPORT_COMPONENT(eeuiSeekbar, AppSeekBar)
WX_EXPORT_METHOD(@selector(setProgress:))

- (instancetype)initWithRef:(NSString *)ref type:(NSString *)type styles:(NSDictionary *)styles attributes:(NSDictionary *)attributes events:(NSArray *)events weexInstance:(WXSDKInstance *)weexInstance
{
    if (self = [super initWithRef:ref type:type styles:styles attributes:attributes events:events weexInstance:weexInstance]) {
        
        if(attributes[@"color"])
        {
            self.color = [WXConvert NSString:attributes[@"color"]]?:@"#000000";
        }
        if(attributes[@"progress"])
        {
            _progress =[WXConvert CGFloat:attributes[@"progress"]]?:0;
        }
        if(attributes[@"min"])
        {
            _min =[WXConvert CGFloat:attributes[@"min"]]?:0;
        }
        if(attributes[@"max"])
        {
            _max =[WXConvert CGFloat:attributes[@"max"]]?:0;
        }
    }
    return self;
}

-(void)viewDidLoad{
    [self update];
    UISlider *sl= (UISlider *)self.view;
   
    [sl addTarget:self action:@selector(sliderProgressChange:) forControlEvents:UIControlEventValueChanged];
    [sl addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [sl addTarget:self action:@selector(sliderTouchUpInSide:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)sliderProgressChange:(UIGestureRecognizer*)e{
    UISlider *sl = (UISlider *) self.view;
    [self fireEvent:@"change" params:@{@"value":@((int) sl.value)}];
}

-(void)sliderTouchDown:(UIGestureRecognizer*)e{
    UISlider *sl = (UISlider *) self.view;
    [self fireEvent:@"start" params:@{@"value":@((int)  sl.value)}];
}

-(void)sliderTouchUpInSide:(UIGestureRecognizer*)e{
    dispatch_async(dispatch_get_main_queue(), ^{
         [self fireEvent:@"stop" params:@{}];
    });
}

-(void)update{
    UISlider *sl = (UISlider *)self.view;
    sl.minimumValue = self.min;
    sl.maximumValue = self.max;
    sl.value = self.progress;
    sl.tintColor = [WXConvert UIColor:self.color];
    [sl setThumbTintColor:[WXConvert UIColor:self.color]];
    UIImage *img = [self toColor:[UIImage imageNamed:@"slid"] color:self.color];
    [sl setThumbImage:img forState:UIControlStateNormal];
    [sl setThumbImage:img forState:UIControlStateHighlighted];
}

- (UISlider *)loadView
{
    return [UISlider new];
}

-(void)updateAttributes:(NSDictionary *)attributes{
    
    if(attributes[@"color"])
    {
        self.color = [WXConvert NSString:attributes[@"color"]]?:@"#000000";
       
    }
    if(attributes[@"progress"])
    {
        _progress =[WXConvert CGFloat:attributes[@"progress"]]?:0;
    }
    if(attributes[@"min"])
    {
        _min =[WXConvert CGFloat:attributes[@"min"]]?:0;
    }
    if(attributes[@"max"])
    {
        _max =[WXConvert CGFloat:attributes[@"max"]]?:0;
    }
    if(attributes.allKeys.count>0){
        [self update];
    }
}

- (void)setProgress:(float)progress
{
    _progress = progress;
    [self update];
    [self fireEvent:@"change" params:@{@"value":@((int) _progress)}];
}

- (UIImage *)toColor:(UIImage *)image color:(NSString *)color
{
    UIColor *c = [WXConvert UIColor:color];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, image.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextClipToMask(context, rect, image.CGImage);
    [c setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
