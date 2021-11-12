//
//  ViewController.m
//  GestureTask
//
//  Created by Maksim Vaselkov on 07.11.2021.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView* redView;
@property (assign, nonatomic) CGFloat redViewScale;
@property (assign, nonatomic) CGFloat redViewRotation;
@property (assign, nonatomic) CGPoint touchOffset;
@property (nonatomic, strong) NSString *archiveName;
@property (nonatomic, strong) NSUserDefaults *defaults;
@property (nonatomic, strong) NSString *humanObjectKey;
@property (nonatomic, strong) NSString *viewInfoObjectKey;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView* redView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds) - 50, CGRectGetMidY(self.view.bounds) - 50, 100, 100)];
    redView.backgroundColor = [UIColor redColor];
    redView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                               UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    self.redView = redView;
    
    [self.view addSubview:redView];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.humanObjectKey = @"humanObjectKey";
    self.viewInfoObjectKey = @"viewInfoObjectKey";
    
    // Tap
    UITapGestureRecognizer* tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleTap:)];
    
    // Double Tap
    UITapGestureRecognizer* doubleTapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleDoubleTap:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    
    // Use (requireGestureRecognizerToFail:) for handle one type gesture at moment
    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    // double Tap Double Gesture
    UITapGestureRecognizer* doubleTapDoubleGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleDoubleTapDoubleGesture:)];
    doubleTapDoubleGesture.numberOfTapsRequired = 2;
    doubleTapDoubleGesture.numberOfTouchesRequired = 2;
    
    // Pinch
    UIPinchGestureRecognizer* pinchGesture =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(handlePinch:)];
    pinchGesture.delegate = self;
    
    // Rotation
    UIRotationGestureRecognizer* rotationGesture =
    [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                 action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    
    // Pan
    UIPanGestureRecognizer* panGesture =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handlePan:)];
    
    // Horizontal swipe
    UISwipeGestureRecognizer* horizontalSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleHorizontalSwipe:)];
    horizontalSwipe.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    horizontalSwipe.delegate = self;
    
    // Vertical swipe
    UISwipeGestureRecognizer* verticalSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleVerticalSwipe:)];
    verticalSwipe.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    verticalSwipe.delegate = self;
    
    [self.view addGestureRecognizer:horizontalSwipe];
    [self.view addGestureRecognizer:verticalSwipe];
    [self.view addGestureRecognizer:pinchGesture];
    [self.view addGestureRecognizer:panGesture];
    [self.view addGestureRecognizer:rotationGesture];
    [self.view addGestureRecognizer:tapGesture];
    [self.view addGestureRecognizer:doubleTapGesture];
    [self.view addGestureRecognizer:doubleTapDoubleGesture];
}

#pragma mark - Methods

- (UIColor*)randomColor {
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

#pragma mark - Gestures

- (void)handleTap:(UITapGestureRecognizer*) tapGesture {
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    self.redView.backgroundColor = [self randomColor];
}

- (void)handleDoubleTap:(UITapGestureRecognizer*) tapGesture {
    NSLog(@"Double Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    [UIView animateWithDuration:0.3 animations:^{
        CGAffineTransform currentTransform = self.redView.transform;
        CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 1.2f, 1.2f);
        
        self.redView.transform = newTransform;
    }];
    
    self.redViewScale = 1.2f;

//    Clothes *clothes = [[Clothes alloc] init];
//    clothes.type = @"Jeans";
//    clothes.color = @"Blue";

    HumansBeing *human = [[HumansBeing alloc] init];
    human.name = @"Alex";
    human.age = 23;
//    human.clothes = clothes;
    
    
    ViewInformation *viewInfo = [[ViewInformation alloc] init];
    viewInfo.colorView = self.redView.backgroundColor;
    viewInfo.viewCoordinate = NSStringFromCGPoint([tapGesture locationInView:self.view]);
    
    [self archivedHuman:human];
    [self archivedViewInformation:viewInfo];
    
    
//    self.archiveName = @"ReferralPromoCodes";
//    [self saveReferralPromoCodes:@"Go to bar"];
}

- (void)handleDoubleTapDoubleGesture:(UITapGestureRecognizer*) tapGesture {
    NSLog(@"Double Tap and Gesture: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    [UIView animateWithDuration:0.3 animations:^{
        CGAffineTransform currentTransform = self.redView.transform;
        CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 0.8f, 0.8f);
        
        self.redView.transform = newTransform;
    }];
    
    self.redViewScale = 0.8f;
    
    HumansBeing *human = [self unarchivedHuman];
    ViewInformation *viewInfo = [self unarchivedViewInfo];
    
    NSLog(@"Human unarchived. Name %@, age %d, color %@", human.name, human.age, human.metaClothes);
    NSLog(@"View info unarchived. Coordinate %@", viewInfo.viewCoordinate);
}

- (void)handlePinch:(UIPinchGestureRecognizer*) pinchGesture {
    NSLog(@"Gesture pinch %1.3f", pinchGesture.scale);
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.redViewScale = 1.0;
    }
    
    CGFloat newScale = 1.0 + pinchGesture.scale - self.redViewScale;
    CGAffineTransform currentTransform = self.redView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    
    self.redView.transform = newTransform;
    self.redViewScale = pinchGesture.scale;
}

- (void)handleRotation:(UIRotationGestureRecognizer*) pinchGesture {
    NSLog(@"Gesture rotation %1.3f", pinchGesture.rotation);
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.redViewRotation = pinchGesture.rotation;
    }
    
    CGFloat newRotation = pinchGesture.rotation - self.redViewRotation;
    CGAffineTransform currentTransform = self.redView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.redView.transform = newTransform;
    self.redViewRotation = pinchGesture.rotation;
}

- (void)handlePan:(UIPanGestureRecognizer*) panGesture {
    NSLog(@"Pan gesture");

    CGPoint pointOnMain = [panGesture locationInView:self.view];
    UIView* view = [self.view hitTest:pointOnMain withEvent:nil];
    
    if ([self.redView isEqual:view]) {
        if (panGesture.state == UIGestureRecognizerStateBegan) {
            CGPoint touchArea = [panGesture locationInView:self.redView];
            self.touchOffset = CGPointMake(CGRectGetMidX(self.redView.bounds) - touchArea.x,
                                           CGRectGetMidY(self.redView.bounds) - touchArea.y);
        }
        
        CGPoint touchOnMainView = [panGesture locationInView:self.view];
        CGPoint correction = CGPointMake(touchOnMainView.x + self.touchOffset.x, touchOnMainView.y + self.touchOffset.y);
        
        self.redView.center = correction;
    }
}

- (void)handleHorizontalSwipe:(UISwipeGestureRecognizer*)horizontSwipe {
    NSLog(@"Horizontal swipe");
}

- (void)handleVerticalSwipe:(UISwipeGestureRecognizer*)verticalSwipe {
    NSLog(@"Vertical swipe");
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UISwipeGestureRecognizer class]];
}

# pragma mark Archive data

- (void)archivedHuman:(HumansBeing *)human {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:human requiringSecureCoding:NO error:nil];
    [self.defaults setObject:data forKey:self.humanObjectKey];
    [self.defaults synchronize];
}

- (void)archivedViewInformation:(ViewInformation *)viewInformation {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:viewInformation requiringSecureCoding:NO error:nil];
    [self.defaults setObject:data forKey:self.viewInfoObjectKey];
    [self.defaults synchronize];
}

- (HumansBeing *)unarchivedHuman {
    NSData *data = [self.defaults dataForKey:self.humanObjectKey];
    
    if (data) {
        __auto_type unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:nil];
        if (unarchiver != nil) {
            unarchiver.requiresSecureCoding = NO;
            HumansBeing *human = [unarchiver decodeObjectForKey:NSKeyedArchiveRootObjectKey];
            [unarchiver finishDecoding];
            NSLog(@"✅Success human unarchive with name %@", human.name);
            return human;
        }
        NSLog(@"❌Can't unarchive Human");
        return [[HumansBeing alloc] init];
    } else {
        NSLog(@"❌Can't unarchive Human");
        return [[HumansBeing alloc] init];
    }
}

- (ViewInformation *)unarchivedViewInfo {
    NSData *data = [self.defaults dataForKey:self.viewInfoObjectKey];
    
    if (data) {
        __auto_type unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:nil];
        if (unarchiver != nil) {
            unarchiver.requiresSecureCoding = NO;
            ViewInformation *viewInfo = [unarchiver decodeObjectForKey:NSKeyedArchiveRootObjectKey];
            [unarchiver finishDecoding];
            NSLog(@"✅Success info unarchive for view with coordinate %@", viewInfo.viewCoordinate);
            return viewInfo;
        }
        NSLog(@"❌Can't unarchive View Info");
        return [[ViewInformation alloc] init];
    } else {
        NSLog(@"❌Can't unarchive View Info");
        return [[ViewInformation alloc] init];
    }
}


# pragma mark - Save data to Documents

- (NSString *)path
{
    NSArray *documentsPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *basePath = [documentsPaths firstObject];
    
    NSLog(@"%@", basePath);
    return [basePath stringByAppendingPathComponent:self.archiveName];
}

- (void)saveReferralPromoCodes:(NSString*)promoCodes
{
    NSLog(@"%@", [self path]);
    [[NSKeyedArchiver archivedDataWithRootObject:promoCodes requiringSecureCoding:NO error:nil] writeToFile:[self path] atomically:NO];
}

@end
