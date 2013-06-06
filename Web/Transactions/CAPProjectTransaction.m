//
//  CAPProjectTransaction.m
//  toggl
//
//  Created by tõnis on 5/29/13.
//  Copyright (c) 2013 Cannedapps. All rights reserved.
//

#import "CAPProjectTransaction.h"
#import "NSString+Additions.h"

NSString *const projectsURL = @"projects/%@";

@interface CAPProjectTransaction () {
    id _payLoad;
}


@end

@implementation CAPProjectTransaction

- (void)addPayload:(id)payLoad
{
    _payLoad = payLoad;
}

- (NSURL *)url
{
    NSString *url = [NSString stringWithFormat:projectsURL, _payLoad[@"pID"]];
    return [NSURL URLWithString:url relativeToURL:baseURI];
}

- (void)addHeadersToHeaders:(NSDictionary *)headers
{
    NSData *data = nil;
    NSString *authorization = nil;
    NSString *authorizationEncoded = nil;
    
    authorization = [NSString stringWithFormat:@"%@:%@", _payLoad[@"user"], _payLoad[@"pass"]];
    data = [authorization dataUsingEncoding:NSUTF8StringEncoding];
    authorizationEncoded = [NSString stringWithFormat:@"Basic %@", [NSString base64ForData:data]];
    
    [headers setValue:@"application/json" forKey:@"Content-type"];
    [headers setValue:authorizationEncoded forKey:@"Authorization"];
}

@end
