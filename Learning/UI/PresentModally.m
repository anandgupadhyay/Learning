// Assuming you have a view controller called 'MyViewController'
MyViewController *vc = [[MyViewController alloc] init];

// Configure the sheet presentation controller
if (vc.sheetPresentationController) {
    vc.sheetPresentationController.detents = @[
                                             [UISheetPresentationControllerDetent mediumDetent]
                                             ];
    vc.sheetPresentationController.largestUndimmedDetentIdentifier = UISheetPresentationControllerDetentIdentifierMedium;
    vc.sheetPresentationController.prefersEdgeAttachedInCompactHeight = YES;
    vc.sheetPresentationController.widthFollowsPreferredContentSizeWhenEdgeAttached = YES;
}

// Set the modal presentation style to form sheet
vc.modalPresentationStyle = UIModalPresentationFormSheet;

// Present the view controller
[self presentViewController:vc animated:YES completion:nil];
