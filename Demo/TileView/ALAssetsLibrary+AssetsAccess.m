//
//  ALAssetsLibrary+AssetsAccess.m
//  CameraRollTest
//
//  Created by #pragmapilot on 17/09/13.
//  Copyright (c) 2013 #pragmapilot. All rights reserved.
//

#import "ALAssetsLibrary+AssetsAccess.h"

#define kAssetsAccessDefaultGroupTypes (ALAssetsGroupSavedPhotos | ALAssetsGroupPhotoStream)

@implementation ALAssetsLibrary (AssetsAccess)

-(void)cameraRollPhotosURLsWithTypes:(ALAssetsGroupType) types
                             success:(CameraRollPhotosDataSuccessBlock) successBlock
                               error:(CameraRollPhotosErrorBlock) errorBlock 
{
    CameraRollPhotosDataSuccessBlock urlSuccessBlock = ^(NSArray *items)
    {
        NSMutableArray *urls = [NSMutableArray array];

        [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset* asset = (ALAsset*) obj;
            ALAssetRepresentation *assetRepresentation = [asset defaultRepresentation];
            [urls addObject:assetRepresentation.url];
        }];

        if(successBlock !=nil)
            successBlock([urls copy]);
    };
     
    [self cameraRollPhotosAssetsWithTypes:types
                                  success:urlSuccessBlock
                                    error:errorBlock];
}

-(void)cameraRollPhotosURLsWithSuccess:(CameraRollPhotosDataSuccessBlock) successBlock 
                                 error:(CameraRollPhotosErrorBlock) errorBlock
{
    [self cameraRollPhotosURLsWithTypes:kAssetsAccessDefaultGroupTypes
                                success:successBlock 
                                  error:errorBlock];
}

- (void)cameraRollPhotosAssetsRepresentationWithTypes:(ALAssetsGroupType) types
                                              success:(CameraRollPhotosDataSuccessBlock) successBlock
                                                error:(CameraRollPhotosErrorBlock) errorBlock 
{
    CameraRollPhotosDataSuccessBlock representationsSuccessBlock = ^(NSArray *items)
    {
        NSMutableArray *assetRepresentations = [NSMutableArray array];

        [items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            ALAsset* asset = (ALAsset*) obj;
            [assetRepresentations addObject:[asset defaultRepresentation]];
        }];

        if(successBlock !=nil)
            successBlock([assetRepresentations copy]);
    };

    [self cameraRollPhotosAssetsWithTypes:types
                                  success:representationsSuccessBlock
                                    error:errorBlock];
}

- (void)cameraRollPhotosAssetsRepresentationWithSuccess:(CameraRollPhotosDataSuccessBlock) successBlock 
                                                  error:(CameraRollPhotosErrorBlock) errorBlock
{
    [self cameraRollPhotosAssetsRepresentationWithTypes:kAssetsAccessDefaultGroupTypes
                                                 success:successBlock 
                                                   error:errorBlock];
}

- (void)cameraRollPhotosAssetsWithTypes:(ALAssetsGroupType) types
                                success:(CameraRollPhotosDataSuccessBlock) successBlock
                                  error:(CameraRollPhotosErrorBlock) errorBlock
{
    NSMutableArray *assets = [NSMutableArray array];

    [self enumerateGroupsWithTypes:types usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if(nil != group)
        {
            // filter photos
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];

            [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {

                if (nil != result)
                {
                    ALAsset *repr = result;
                    [assets addObject:repr];
                }
                else // enumeration ends with nil. So if we're done...
                {
                    //...and we have a success block, call it!
                    if(successBlock != nil)
                        successBlock([assets copy]);
                }
            }];
        }

        *stop = NO;
    } failureBlock:^(NSError *error) {
        // Oops...
        if(errorBlock != nil)
            errorBlock(error);
    }];
}

-(void)cameraRollPhotosAssetsWithSuccess:(CameraRollPhotosDataSuccessBlock) successBlock
                                   error:(CameraRollPhotosErrorBlock) errorBlock
{
    [self cameraRollPhotosAssetsWithTypes:kAssetsAccessDefaultGroupTypes
                                  success:successBlock
                                    error:errorBlock];
}

@end
