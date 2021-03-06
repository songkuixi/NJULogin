//
//  YoshikoTextField.m
//  BWWalkthroughExample
//
//  Created by mukesh mandora on 24/07/15.
//  Copyright (c) 2015 Yari D'areglia. All rights reserved.
//

#import "YoshikoTextField.h"

@interface YoshikoTextField (){
    CGFloat inset;
    
    CALayer *borderTextField;
    CGPoint textFieldInset,placeholderInset;
}
@property (strong ,nonatomic) UILabel *placeHolderLabel;
@property (nonatomic) CGFloat placeholderHeight;

@end
@implementation YoshikoTextField
@synthesize placeHolderLabel;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    borderTextField=[[CALayer alloc] init];
    borderTextField.frame = CGRectMake(0, 25, self.bounds.size.width, self.bounds.size.height-25);
    borderTextField.borderColor=[UIColor clearColor].CGColor;
    borderTextField.borderWidth=1.5;
    borderTextField.backgroundColor=[UIColor grayColor].CGColor;
    [self.layer addSublayer:borderTextField];
    [self addPlaceHolderLabel];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self=[super initWithCoder:aDecoder];
    self.delegate = self;
    if (self) {
        self.placeHolderLabel = [[UILabel alloc] init];
        self.placeHolderLabel.text = self.placeholder;
        self.placeHolderLabel.textColor = [UIColor clearColor];
        self.placeHolderLabel.backgroundColor=[UIColor clearColor];
        self.placeHolderLabel.font = [UIFont fontWithName:@"Avenir" size:14.0];
        self.placeHolderLabel.textAlignment = NSTextAlignmentLeft;
        
        placeholderInset = CGPointMake(6, 6);
        textFieldInset = CGPointMake(6, 6);
        
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)setPlaceholderHeight:(CGFloat)placeholderHeight{
    
}

-(CGFloat)placeholderHeight{
    UIFont *fontOfText=[UIFont fontWithName:@"Avenir" size:self.font.pointSize*0.7];
    return placeholderInset.y+fontOfText.lineHeight;
}

- (void)addPlaceHolderLabel{
    self.placeHolderLabel.frame=CGRectMake(textFieldInset.x*2, self.bounds.size.height/2, self.bounds.size.width-textFieldInset.x*4, 20);
    [self addSubview:self.placeHolderLabel];
}

-(void)setBorderLayer{
    
}

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectOffset(self.bounds,textFieldInset.x*2, self.bounds.size.height/2-textFieldInset.y*2);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    [UIView transitionWithView:self.placeHolderLabel duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
        self.placeHolderLabel.frame=CGRectMake(textFieldInset.x*2, 0, self.bounds.size.width-textFieldInset.x*4, 20);
        [self.placeHolderLabel setText:[self.placeholder uppercaseString]];
        [self.placeHolderLabel setTextColor:[UIColor colorWithRed:1 green:0.4 blue:0 alpha:1]];
        borderTextField.backgroundColor=[UIColor whiteColor].CGColor;
         borderTextField.borderColor=[UIColor colorWithRed:1 green:0.4 blue:0 alpha:1].CGColor;
    } completion:^(BOOL finished) {
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    if([textField.text isEqual:@""]){
        
        [UIView transitionWithView:self.placeHolderLabel duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [self.placeHolderLabel setTextColor:[UIColor clearColor]];
            self.placeHolderLabel.frame=CGRectMake(textFieldInset.x*2, self.bounds.size.height/2, self.bounds.size.width-textFieldInset.x*4, 20);
            [self.placeHolderLabel setText:[self.placeholder capitalizedString]];
            borderTextField.backgroundColor=[UIColor grayColor].CGColor;
            borderTextField.borderColor=[UIColor clearColor].CGColor;
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

@end


