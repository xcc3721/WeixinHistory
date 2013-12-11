//
//  PXPreferencesController.h
//  Photon
//
//  Created by Logan Collins on 8/14/12.
//  Copyright (c) 2011 Sunflower Softworks. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Photon/PXPreferencePane.h>


/*!
 * @class PXPreferencesController
 * @abstract A preferences window controller
 * 
 * @discussion
 * The controller manages a series of panes that are displayed as a preferences window.
 */
@interface PXPreferencesController : NSResponder

/*!
 * @method sharedController
 * @abstract Gets the default preferences controller
 * 
 * @result A PXPreferencesController object
 */
+ (PXPreferencesController *)defaultController;


/*!
 * @property autosaveIdentifier
 * @abstract The preferences controller autosave identifier
 * 
 * @result An NSString object
 */
@property (copy) NSString *autosaveIdentifier;

/*!
 * @property window
 * @abstract The preferences controller window
 *
 * @result An NSWindow object
 */
@property (strong, readonly) NSWindow *window;


/*!
 * @property preferencePanes
 * @abstract Gets the array of preference panes.
 * 
 * @result An NSArray of PXPreferencePane objects
 */
@property (strong, readonly) NSArray *preferencePanes;

/*!
 * @property currentPreferencePane
 * @abstract Gets the current preference pane.
 * 
 * @result A PXPreferencePane object
 */
@property (strong, readonly) PXPreferencePane *currentPreferencePane;

/*!
 * @method preferencePaneWithIdentifier:
 * @abstract Gets the preference pane with a specific identifier (or nil if none exists)
 * 
 * @param identifier
 * The identifier of the preference pane to get
 * 
 * @result A PXPreferencePane object
 */
- (PXPreferencePane *)preferencePaneWithIdentifier:(NSString *)identifier;

/*!
 * @method preferencePaneAtIndex:
 * @abstract Gets the preference pane at a specific index
 * 
 * @param index
 * The index of the preference pane to get
 * 
 * @result A PXPreferencePane object
 */
- (PXPreferencePane *)preferencePaneAtIndex:(NSUInteger)index;

/*!
 * @method addPreferencePane:
 * @abstract Append a preference pane to the receiver
 * 
 * @param preferencePane
 * The preference pane to add
 */
- (void)addPreferencePane:(PXPreferencePane *)preferencePane;

/*!
 * @method insertPreferencePane:atIndex:
 * @abstract Append a preference pane to the receiver
 * 
 * @param preferencePane
 * The preference pane to insert
 * 
 * @param index
 * The index at which to insert the preference pane
 */
- (void)insertPreferencePane:(PXPreferencePane *)preferencePane atIndex:(NSUInteger)index;

/*!
 * @method removePreferencePaneAtIndex:
 * @abstract Removes the preference pane at a specified index from the receiver
 * 
 * @param index
 * The index of the preference pane to remove
 */
- (void)removePreferencePaneAtIndex:(NSUInteger)index;

/*!
 * @method removePreferencePane:
 * @abstract Removes a specified preference pane from the receiver
 * 
 * @param preferencePane
 * The preference pane to remove
 */
- (void)removePreferencePane:(PXPreferencePane *)preferencePane;


/*!
 * @method showPreferencePaneWithIdentifier:
 * @abstract Switch to the preference pane with a specified identifier
 * 
 * @param identifier
 * The identifier of the pane to which to switch
 */
- (void)showPreferencePaneWithIdentifier:(NSString *)identifier;


/*!
 * @method showWindow:
 * @abstract Shows the receiver's window
 *
 * @param sender
 * The action sender
 */
- (IBAction)showWindow:(id)sender;

@end
