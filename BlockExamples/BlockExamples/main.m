//
//  main.m
//  BlockExamples
//
//  Created by jeff Omidvaran on 2/8/22.
//

#import <Foundation/Foundation.h>

@interface Problem: NSObject
@end

@implementation Problem
// #####################################
// ####### BLOCK WITH NO ARGS ##########
// #####################################
-(void) noArgs: (void (^)(void)) theBlock {
    theBlock();
}

// #####################################
// ####### BLOCK WITH ARGS #############
// #####################################
-(void) withArgs: (void (^) (BOOL test)) theBlock {
    theBlock(YES);
}



// ##############################################
// ####### BLOCK WITH RETURN ####################
// ##############################################
-(int) withReturn: ( int (^)(void)) block {
    return block();
}



// ##############################################
// ####### BLOCK WITH RETURN AND ARGS ###########
// ##############################################
-(int) withReturnAndArgs: (int (^)(int num)) block {
    return block(10);
}
@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Problem * p = [[Problem alloc] init];
        
        // NO RETURN NO ARGS
        [p noArgs:^{ NSLog(@"no args print"); }];
        
        // WITH ARGS
        [p withArgs:^(BOOL test) {
            if(test) { NSLog(@"with args"); }
        }];
        
        int val = [p withReturn:^ {
            return 9;
        }];
        NSLog(@"%d", val);
        
        // RETURN VALUE AND ARGS
        val = [p withReturnAndArgs: ^(int num) {
            return num + 1;
        }];
        
        NSLog(@"%d", val);
    }
    return 0;
}
