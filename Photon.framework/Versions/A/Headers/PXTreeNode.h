//
//  PXTreeNode.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2012 Sunflower Softworks. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 * @protocol PXTreeNode
 * @abstract Implemented by objects participating in a tree of objects
 */
@protocol PXTreeNode <NSObject>

@required

- (NSString *)title;    /* The title of the item */
- (NSImage *)image;     /* The image of the item */
- (NSUInteger)order;    /* The order of the item, 0 is lowest */
- (NSSet *)children;    /* The set of child items */

- (BOOL)isSelectable;   /* If the item is selectable by the user */
- (BOOL)isEditable;     /* If the item is editable by the user */
- (BOOL)isGroupItem;    /* If the item is a group heading */

@optional

- (NSString *)persistenceIdentifier; /* A unique string representation of the receiver, or nil */

@end


/*!
 * @class PXTreeNode
 * @abtract A concrete, generic implementation of the PXTreeNode protocol
 */
@interface PXTreeNode : NSObject <PXTreeNode>

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSImage *image;
@property (nonatomic) NSUInteger order;

@property (nonatomic, copy) NSSet *children;
- (void)addChild:(id <PXTreeNode>)child;
- (void)removeChild:(id <PXTreeNode>)child;

@property (nonatomic, getter=isSelectable) BOOL selectable;
@property (nonatomic, getter=isEditable) BOOL editable;
@property (nonatomic, getter=isGroupItem) BOOL groupItem;

@property (nonatomic, copy) NSString *persistenceIdentifier;

@end
