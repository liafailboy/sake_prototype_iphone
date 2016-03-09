//
//  detailViewController.m
//  sake_prototype
//
//  Created by Shotaro Watanabe on 3/2/16.
//  Copyright © 2016 liafailboy. All rights reserved.
//

#import "detailViewController.h"

@interface detailViewController ()

@end

@implementation detailViewController

#define navigationBarY 65

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // get the store data of sake
    defaults = [NSUserDefaults standardUserDefaults];
    arrayOfSakeDictionary = [defaults mutableArrayValueForKey:@"arrayOfSakeDictionary"];
    arrayOfDrunkSakeID = [defaults objectForKey:@"drunkSakeID"];
    
    // get the sakeID from previous view
    [self getSakeID];
    
    // set the UIView for navigation bar
    [self setUpNavigationBar];
    
    // set the view change button
    [self setUpViewChangeButton];
    
    // set the scroll view
    [self setUpScrollView];
}

- (void)setUpNavigationBar {
    
    // initialize navigation bar on the main screen
    UIView *statusBar = [[UIView alloc]  initWithFrame:CGRectMake(0, 0, 375, 20)];
    
    // set the background color of navigation bar to light gray
    statusBar.backgroundColor = [UIColor whiteColor];
    
    // add navigation bar into main screen
    [self.view addSubview:statusBar];
    
    // initialize navigation bar on the main screen
    UIView *navigationBar = [[UIView alloc]  initWithFrame:CGRectMake(0, 20, 375, 45)];
    
    // set the background color of navigation bar to light gray
    navigationBar.backgroundColor = [UIColor lightGrayColor];
    
    // add navigation bar into main screen
    [self.view addSubview:navigationBar];
}

- (void)setUpViewChangeButton {
    
    // intitalize image and button
    UIImage *buttonImage = [UIImage imageNamed:@"back_to_grid.png"];
    
    // initialize button
    UIButton *buttonForViewChange = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // set the location and the size of the button
    [buttonForViewChange setFrame:CGRectMake(17, 27, 30, 30)];
    
    // set the image of buttons
    [buttonForViewChange setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    // call action method when button is pushed
    [buttonForViewChange addTarget:self action:@selector(backToMainButtonPushed:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    // add the buttons to the scrollview
    [self.view addSubview:buttonForViewChange];
}

- (void)backToMainButtonPushed:(UIButton *) button {
    // initiazlize animation effect to push new view controller from right to left
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)getSakeID {
    sakeIDNumber = (int)[defaults integerForKey:@"sakeID"];
}

- (void)setUpScrollView {
    
    // initialize scrollView to make page based view
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, navigationBarY, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY)];
        
    // set the size of the content to the width of screen with three pages
    contentSize = CGSizeMake(self.view.bounds.size.width * 3
                             ,self.view.bounds.size.height - navigationBarY);
    scrollView.contentSize = contentSize;
    
    // set the delegate of scrollview to self
    scrollView.delegate = self;
    
    // set the scrollView to page based
    scrollView.pagingEnabled = YES;
    
    [self addInformationOnScrollView];
    
    // add scrollView to main screen
    [self.view addSubview:scrollView];
}

- (void)addInformationOnScrollView {
    
    // get the sake date from shared array from previous view
    NSDictionary *sakeDictionary = [arrayOfSakeDictionary objectAtIndex:sakeIDNumber];
    
    // initialize labels for sake information
    UILabel *labelOfSakeName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    UILabel *labelOfSakePre = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    UILabel *labelOfSakeCity = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    UILabel *labelOfSakeCom = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    UILabel *labelOfSakeAci = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    UILabel *labelOfSakeMeter = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 100)];
    
    // set the location of each label
    labelOfSakeName.center = CGPointMake(contentSize.width / 6, contentSize.height / 2);
    labelOfSakePre.center = CGPointMake(contentSize.width / 2 , contentSize.height / 2 - 50);
    labelOfSakeCity.center = CGPointMake(contentSize.width / 2, contentSize.height / 2);
    labelOfSakeCom.center = CGPointMake(contentSize.width / 2, contentSize.height / 2 + 50);
    labelOfSakeAci.center = CGPointMake(contentSize.width * 5 / 6, contentSize.height / 2 - 25);
    labelOfSakeMeter.center = CGPointMake(contentSize.width * 5 / 6, contentSize.height / 2 + 25);
    
    // set the alignment of labels to center
    labelOfSakeName.textAlignment = NSTextAlignmentCenter;
    labelOfSakePre.textAlignment = NSTextAlignmentCenter;
    labelOfSakeCity.textAlignment = NSTextAlignmentCenter;
    labelOfSakeCom.textAlignment = NSTextAlignmentCenter;
    labelOfSakeAci.textAlignment = NSTextAlignmentCenter;
    labelOfSakeMeter.textAlignment = NSTextAlignmentCenter;
    
    // adjust the font size to the width of the label
    [labelOfSakeName setFont:[UIFont fontWithName:@"Helvetica" size:48.0]];
    [labelOfSakePre setFont:[UIFont fontWithName:@"Helvetica" size:48.0]];
    [labelOfSakeCity setFont:[UIFont fontWithName:@"Helvetica" size:48.0]];
    [labelOfSakeCom setFont:[UIFont fontWithName:@"Helvetica" size:48.0]];
    [labelOfSakeAci setFont:[UIFont fontWithName:@"Helvetica" size:48.0]];
    [labelOfSakeMeter setFont:[UIFont fontWithName:@"Helvetica" size:48.0]];
    
    // adjust the font size if it does not fit the width
    labelOfSakeName.adjustsFontSizeToFitWidth = YES;
    labelOfSakePre.adjustsFontSizeToFitWidth = YES;
    labelOfSakeCity.adjustsFontSizeToFitWidth = YES;
    labelOfSakeCom.adjustsFontSizeToFitWidth = YES;
    labelOfSakeAci.adjustsFontSizeToFitWidth = YES;
    labelOfSakeMeter.adjustsFontSizeToFitWidth = YES;
    

    // set the text to label from sake dictionary
    labelOfSakeName.text = [sakeDictionary objectForKey:@"NAME"];
    labelOfSakePre.text = [NSString stringWithFormat:@"都道府県: %@",[sakeDictionary objectForKey:@"PREFECTURE"]];
    labelOfSakeCity.text = [NSString stringWithFormat:@"都市: %@",[sakeDictionary objectForKey:@"CITY"]];
    labelOfSakeCom.text = [NSString stringWithFormat:@"醸造元: %@",[sakeDictionary objectForKey:@"COMPANY"]];
    labelOfSakeAci.text = [NSString stringWithFormat:@"酸度: %@", [sakeDictionary objectForKey:@"ACIDITY"]];
    labelOfSakeMeter.text = [NSString stringWithFormat:@"日本酒度: %@", [sakeDictionary objectForKey:@"SAKE_METER"]];
    
    // add labels to the view
    [scrollView addSubview:labelOfSakeName];
    [scrollView addSubview:labelOfSakePre];
    [scrollView addSubview:labelOfSakeCity];
    [scrollView addSubview:labelOfSakeCom];
    [scrollView addSubview:labelOfSakeAci];
    [scrollView addSubview:labelOfSakeMeter];
    
    // add imageView if it is already exist
    int sakeID = [[sakeDictionary objectForKey:@"SAKE_ID"] intValue];
    
    if ([arrayOfDrunkSakeID containsObject:[NSNumber numberWithInt:sakeID]]) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[[NSString stringWithFormat:@"detail_sake_%d", sakeID] stringByAppendingString:@".png"]]];
        imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - navigationBarY);
        [scrollView addSubview:imageView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
