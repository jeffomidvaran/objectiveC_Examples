//
//  ViewController.m
//  GCD_Testing
//
//  Created by jeff Omidvaran on 2/9/22.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

-(void) groupExample {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        NSLog(@"Block1");
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"Block1 End");
    });
    
    dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        NSLog(@"Block2");
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"Block2 End");
    });
    
    dispatch_group_notify(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^ {
        NSLog(@"Block3");
        NSLog(@"Block3 End");
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}


-(void) asyncGlobalExample {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^ {
        NSLog(@"from global queue");
    });
}


-(void) semaphoreExample {
    dispatch_queue_t queue = dispatch_queue_create("label", NULL);
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_async(queue, ^{
        NSLog(@"block 1");
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"block 1 end");
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER); // decrements
    });
    
    dispatch_semaphore_signal(sema); // increments
    dispatch_async(queue, ^{
        NSLog(@"block 2");
        NSLog(@"block 2 end");
    });
}


-(void) mainTheadExample {
    dispatch_async(dispatch_get_main_queue(), ^ {
        NSLog(@"On the main thread");
    });
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // [self groupExample];
    // [self semaphoreExample];
    // [self mainTheadExample];
    [self asyncGlobalExample];
}


@end
