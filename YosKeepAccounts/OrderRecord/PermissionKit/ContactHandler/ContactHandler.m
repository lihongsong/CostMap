//
//  ContactHandler.m
//  
//
//  Created by terrywang on 2018/12/16.
//  Copyright © 2018 . All rights reserved.
//
#define RGBCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

#import "ContactHandler.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "PermissionManager.h"

@interface ContactHandler()<ABPeoplePickerNavigationControllerDelegate, CNContactPickerDelegate>

@property (nonatomic, copy) contactselectedCompletionBlock completionHandler;

@end

@implementation ContactHandler

- (void)contactSelectWithViewController:(_Nonnull id)viewController
                             completion:(_Nullable contactselectedCompletionBlock)completion {

    if (![viewController isKindOfClass:[UIViewController class]]) {
        return;
    }

    _completionHandler = completion;
    [PermissionManager checkContactPermissionWithResult:^(BOOL allow) {
        if (!allow) {
            NSLog(@"通讯录权限未开启");
            if (_completionHandler) {
                _completionHandler(nil, kErrNoContactsText);
            }
            return ;
        }

        if (NSClassFromString(@"CNContactPickerViewController")) {
            // iOS 9, 10, use CNContactPickerViewController
            if (@available(iOS 9.0, *)) {
                CNContactPickerViewController *contactPickerVC = [[CNContactPickerViewController alloc] init];
                contactPickerVC.delegate = self;
                contactPickerVC.displayedPropertyKeys = @[CNContactPhoneNumbersKey];
                [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
                //Setting the UIBarButtonItem's title
                [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLORV(0x3097fd)}
                                                            forState:UIControlStateNormal];

                [viewController presentViewController:contactPickerVC
                                             animated:YES
                                           completion:^{
                                               //重置状态栏样式
                                               [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
                                           }];
            }
        } else {
            // iOS 8 Below, use ABPeoplePickerNavigationController
            ABPeoplePickerNavigationController *peoplePickerNC = [[ABPeoplePickerNavigationController alloc] init];
            peoplePickerNC.peoplePickerDelegate = self;
            //联系人信息中仅显示联系人的电话
            peoplePickerNC.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];

            [viewController presentViewController:peoplePickerNC animated:YES completion:^{
                //重置状态栏样式
                [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            }];
        }

    } showAlert:YES];

}

#pragma mark --CNContactPickerDelegate iOS9及以上
- (void)contactPicker:(CNContactPickerViewController *)picker
didSelectContactProperty:(CNContactProperty *)contactProperty NS_AVAILABLE_IOS(9_0){
    CNPhoneNumber *phoneNumber = contactProperty.value;
    NSString *identifier = contactProperty.contact.identifier;

    if (!identifier) {
        if (_completionHandler) {
            _completionHandler(nil, kErrNoContactsText);
        }
        return;
    }

    NSString *name = [CNContactFormatter stringFromContact:contactProperty.contact
                                                     style:CNContactFormatterStyleFullName];

    self.contactsModel.name = name;
    NSString *phoneNumberStr = phoneNumber.stringValue;
    if (!phoneNumberStr) {
        if (_completionHandler) {
            _completionHandler(nil, kErrNoContactsText);
        }
        return;
    }

    if (phoneNumberStr) {
        //更新联系人信息
        self.contactsModel.phones = [NSArray arrayWithObjects:phoneNumberStr, nil];
    }
    //block 回调出去
    if (_completionHandler) {
        _completionHandler(_contactsModel, nil);
    }
}

- (ContactsModel *)contactsModel {
    if (!_contactsModel) {
        _contactsModel = [[ContactsModel alloc] init];
    }
    return _contactsModel;
}


#pragma mark - ABPeoplePickerNavigationControllerDelegate
//用户点击取消按钮
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}

//兼容 iOS8
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
                         didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier {
    [self selectPerson:person property:property identifier:identifier];
}

//兼容 iOS8
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

//兼容 iOS8
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    [self selectPerson:person property:property identifier:identifier];

    [peoplePicker dismissViewControllerAnimated:YES completion:nil];

    return NO;
}

#pragma mark -selectPerson
- (void)selectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {

    if (property != kABPersonPhoneProperty
        || identifier == kABMultiValueInvalidIdentifier) {
        if (_completionHandler) {
            //选择的号码无效时
            _completionHandler(nil, kErrNoContactsText);
        }
        return;
    }

    NSString *name = (__bridge NSString *)ABRecordCopyCompositeName(person);

    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person,kABPersonPhoneProperty);
    NSInteger index =  ABMultiValueGetIndexForIdentifier(phoneMulti, identifier);

    /** 检查手机号是否有效 */
    if (index == kABMultiValueInvalidIdentifier) {
        CFRelease((__bridge CFTypeRef)(name));
        CFRelease(phoneMulti);
        if (_completionHandler) {
            _completionHandler(nil, kErrNoContactsText);
        }
        return;
    }

    NSString *phoneNumberStr = nil;

    /*
     修改bugly https:bugly.qq.com/v2/crash-reporting/crashes/900025468/969?pid=2
     参考方法 https:stackoverflow.com/questions/1117575/how-do-you-get-a-persons-phone-number-from-the-address-book/1213657#1213657
     */
    ABMultiValueRef multiPhones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    for(CFIndex i = 0; i < ABMultiValueGetCount(multiPhones); i++) {
        if(identifier == ABMultiValueGetIdentifierAtIndex (multiPhones, i)) {
            CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
            phoneNumberStr = (__bridge NSString *) phoneNumberRef;
            phoneNumberStr = [phoneNumberStr substringFromIndex:0];
            CFRelease(phoneNumberRef);
        }
    }

    CFRelease(phoneMulti);
    CFRelease(multiPhones);

    if (phoneNumberStr) {
        self.contactsModel.phones = [NSArray arrayWithObjects:phoneNumberStr, nil];
    }
    if (name) {
        self.contactsModel.name = name;
    }
    CFRelease((__bridge CFTypeRef)(name));
    if (_completionHandler) {
        _completionHandler(_contactsModel, nil);
    }
}

@end
