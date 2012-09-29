//
//  ViewController.m
//  OpenSSLRSAWrapper
//
//  Created by sban@netspectrum.com on 9/29/12.
//  Copyright (c) 2012 sban@netspectrum.com. All rights reserved.
//

#import "ViewController.h"
#import "OpenSSLRSAWrapper.h"

@interface ViewController ()
@property (nonatomic,strong) IBOutlet UITextView *tv;
@end

@implementation ViewController
@synthesize tv;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSMutableString *string = [NSMutableString stringWithCapacity:0];
    
    //test
    OpenSSLRSAWrapper *wrapper = [OpenSSLRSAWrapper shareInstance];
    [string appendString:@"Start generate key pair...\n"];
    self.tv.text = string;
    
    if([wrapper generateRSAKeyPairWithKeySize:1024]){
        [string appendString:@"Done!\n"];
        self.tv.text = string;
        [string appendString:@"Start export keys...\n"];
        
        [wrapper exportRSAKeys];
        
        self.tv.text = string;
        [string appendString:@"Done!\n\n"];
        self.tv.text = string;
        
        //public key
        [string appendString:@"public key \n------------------------------------------"];
        self.tv.text = string;
        
        [string appendFormat:@"%@",wrapper.publicKeyBase64];
        self.tv.text = string;
        
        [string appendString:@"------------------------------------------\n"];
        self.tv.text = string;
        
        //private key
        [string appendString:@"private key \n------------------------------------------"];
        self.tv.text = string;
        
        [string appendFormat:@"%@",wrapper.privateKeyBase64];
        self.tv.text = string;
        
        [string appendString:@"------------------------------------------\n"];
        self.tv.text = string;
        
//        NSLog(@"public key:\n%@\n",wrapper.publicKeyBase64);
//        NSLog(@"private key:\n%@\n",wrapper.privateKeyBase64);
        
        NSString *plainText = @"OpenSSLRSAWrapper is simple and useful.";
        
        [string appendFormat:@"Start encrypt plain text...\nContent :%@\n",plainText];
        self.tv.text = string;
        
        NSData *encryptData = [wrapper encryptRSAKeyWithType:KeyTypePrivate plainText:plainText];
        
        
        [string appendString:@"Done!\n"];
        self.tv.text = string;
        
        
        [string appendString:@"Start decrypt...\n"];
        self.tv.text = string;
        
        NSString *decryptString = [wrapper decryptRSAKeyWithType:KeyTypePublic data:encryptData];
        
        [string appendString:@"Done!\n"];
        self.tv.text = string;
        
        [string appendFormat:@"The decrypted plain text is %@\n",decryptString];
        self.tv.text = string;
        
        NSLog(@"plain text : >>>>%@<<<<\n",decryptString);
    }

}

@end
