//
//  FunnyViewController.m
//  FunnyImage
//
//  Created by admin on 6/4/15.
//  Copyright (c) 2015 HUNGCAO. All rights reserved.
//

#import "FunnyViewController.h"
#import "CropperImageView.h"

@interface FunnyViewController (){
    CropperImageView *cropperImageView;
    
    UIImageView *currentImageView;
}

@end

@implementation FunnyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Generate a background image with result image
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [bgImageView setImage:[UIImage imageNamed:@"Leonardo_Bald"]];
    [self.view addSubview:bgImageView];
    
    //Generate a view with an image which needing to effect
    cropperImageView = [[CropperImageView alloc] initWithFrame:self.view.bounds];
    [cropperImageView setImage:[UIImage imageNamed:@"Leonardo_Hair"]];
    [cropperImageView setAlpha:1.0];
    [self.view addSubview:cropperImageView];
    
    //Create a reset button to original image
    UIBarButtonItem *resetButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Reset" style:UIBarButtonItemStyleDone target:self action:@selector(resetButtonClicked)];
    [self.navigationItem setRightBarButtonItem:resetButtonItem];
}

-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"\nSize: %@, image: %@",NSStringFromCGRect(cropperImageView.frame),NSStringFromCGSize(cropperImageView.image.size));
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) resetButtonClicked{
    [cropperImageView setImage:nil];
    [cropperImageView setImage:[UIImage imageNamed:@"Leonardo_Hair"]];
}
@end
