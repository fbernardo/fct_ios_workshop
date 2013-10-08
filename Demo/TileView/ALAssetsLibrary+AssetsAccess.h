//
//  ALAssetsLibrary+AssetsAccess.h
//  CameraRollTest
//
//  Created by #pragmapilot on 17/09/13.
//  Copyright (c) 2013 #pragmapilot. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

/**
 @abstract defines the block signature to handle the camera roll photo data successful fetching
 @param urls the camera rolls photo URLs
 */
typedef void(^CameraRollPhotosDataSuccessBlock)(NSArray* items);

/**
 @abstract defines the block signature to handle the camera roll photo data fetching failure
 @param error the error
 */
typedef void(^CameraRollPhotosErrorBlock)(NSError *error);

/** 
 @abstract defines extension methods to help dealing with the assets
 @discussion client code should know what kind of data it requested and handle it's the extraction from the passed data array
 */
@interface ALAssetsLibrary (AssetsAccess)

/**
 @abstract returns, via callback block, the list of the existing photos URLs on the device's camera roll
 @param successBlock the success callback
 @param errorBlock the error callback
 */
-(void)cameraRollPhotosURLsWithSuccess:(CameraRollPhotosDataSuccessBlock) successBlock
                                 error:(CameraRollPhotosErrorBlock) errorBlock;

/**
 @abstract returns, via callback block, the list of the existing photos URLs on the device's camera roll
 @param types the types of asset group that should be returned. The value is a bitfield.
 @param successBlock the success callback
 @param errorBlock the error callback
 */
-(void)cameraRollPhotosURLsWithTypes:(ALAssetsGroupType) types
                             success:(CameraRollPhotosDataSuccessBlock) successBlock
                               error:(CameraRollPhotosErrorBlock) errorBlock;

/**
 @abstract returns, via callback block, the list of assets of the existing photos on the device's camera roll
 @param successBlock the success callback
 @param errorBlock the error callback
 */
-(void)cameraRollPhotosAssetsWithSuccess:(CameraRollPhotosDataSuccessBlock) successBlock
                                   error:(CameraRollPhotosErrorBlock) errorBlock;

/**
 @abstract returns, via callback block, the list of assets of the existing photos on the device's camera roll
 @param types the types of asset group that should be returned. The value is a bitfield.
 @param successBlock the success callback
 @param errorBlock the error callback
 */
- (void)cameraRollPhotosAssetsWithTypes:(ALAssetsGroupType) types
                                success:(CameraRollPhotosDataSuccessBlock) successBlock
                                  error:(CameraRollPhotosErrorBlock) errorBlock;

/**
 @abstract returns, via callback block, the list of asset representations of the existing photos on the device's camera roll
 @param successBlock the success callback
 @param errorBlock the error callback
 */
-(void)cameraRollPhotosAssetsRepresentationWithSuccess:(CameraRollPhotosDataSuccessBlock) successBlock
                                                 error:(CameraRollPhotosErrorBlock) errorBlock;

/**
 @abstract returns, via callback block, the list of asset representations of the existing photos on the device's camera roll
 @param types the types of asset group that should be returned. The value is a bitfield.
 @param successBlock the success callback
 @param errorBlock the error callback
 */
- (void)cameraRollPhotosAssetsRepresentationWithTypes:(ALAssetsGroupType) types
                                              success:(CameraRollPhotosDataSuccessBlock) successBlock
                                                error:(CameraRollPhotosErrorBlock) errorBlock;

@end
