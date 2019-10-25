//
//  PublicUserDataResponse.swift
//  OnTheMapRoniR
//
//  Created by Roni Rozenblat on 10/2/19.
//  Copyright © 2019 dinatech. All rights reserved.
//

import Foundation

struct PublicUserDataResponse: Codable {
    let last_name:String?
    /*let social_accounts: [Any]?
    let mailing_address:String?
    let _cohort_keys: [Any]?
    let signature: String?
    let _stripe_customer_id:String?
    let _guard:Any?
    let _facebook_id: String?
    let timezone: String?
    let site_preferences:String?
    let occupation:String?
    let _image:String?*/
    let first_name:String?
    /*let jabber_id:String?
    let languages:String?
    let _badges: [Any]?
    let location: String?
    let external_service_password:String?
    let _principals:[Any]?
    let _enrollments:[Any]?
    let email:PUDREmailObjectResponse?
    let website_url:String?
    let external_accounts:[Any]?
    let bio:String?
    let coaching_data:String?
    let tags: [Any]?
    let _affiliate_profiles: [Any]?
    let _has_password:Bool?
    let email_preferences:String?
    let _resume:String?
    let key:String?
    let nickname: String?
    let employer_sharing:Bool?
    let _memberships: [Any]?
    let zendesk_id:String?
    let _registered:Bool?
    let linkedin_url:String?
    let _google_id:String?
    let _image_url:String?
    let emailAddressVal:String?
    let _verifiedVal:Bool?
    let _verification_code_sent:Bool?
    */
    
    
    // default struct initializer
    init(last_name:String?, /*social_accounts: [Any]?, mailing_address:String?,_cohort_keys:[Any]?,signature: String?,_stripe_customer_id:String?,_guard:Any?,_facebook_id:String?, timezone:String?, site_preferences:String?, occupation:String?, _image:String?,*/first_name:String?/*, jabber_id:String?, languages:String?,_badges:[Any]?,location:String?, external_service_password:String?,_principals: [Any]?,_enrollments:[Any]?,
         email:PUDREmailObjectResponse?,
     website_url:String?,external_accounts: [Any]?, bio:String?, coaching_data:String?,tags: [Any]?, _affiliate_profiles: [Any]?,
     _has_password:Bool?, email_preferences:String?, _resume:String?, key:String?, nickname:String?, employer_sharing:Bool?, _memberships: [Any]?,
     zendesk_id:String?, _registered:Bool?, linkedin_url:String?, _google_id:String?, _image_url:String?, emailAddressVal:String?,_verifiedVal:Bool?,_verification_code_sent:Bool?*/)
    {
        
  
        // 1)
        self.last_name = last_name
        
        /*// 2)
        self.social_accounts = social_accounts
        
        // 3)
        self.mailing_address = mailing_address
        
        // 4)
        self._cohort_keys = _cohort_keys
        
        // 5)
        self.signature = signature
        
        // 6)
        self._stripe_customer_id = _stripe_customer_id
        
        // 7)
        self._guard = _guard
        
        // 8)
        self._facebook_id = _facebook_id
        
        // 9)
        self.timezone = timezone
        
        // 10)
        self.site_preferences = site_preferences
        
        // 11)
        self.occupation = occupation
        
        // 12)
        self._image = _image
        */
        // 13)
        self.first_name = first_name
        /*
        // 14)
        self.jabber_id = jabber_id
        
        // 15)
        self.languages = languages
        
        // 16)
        self._badges = _badges
        
        // 17)
        self.location = location
        
        // 18)
        self.external_service_password = external_service_password
        
        // 19)
        self._principals = _principals
        
        // 20)
        self._enrollments = _enrollments
        
        // 21)
        self.email = email
        
        // 22)
        self.website_url = website_url
        
        // 23)
        self.external_accounts = external_accounts
        
        // 23)
        self.coaching_data = coaching_data
        
        // 24)
        self.tags = tags
        
        // 25)
        self._affiliate_profiles = _affiliate_profiles
        
        // 26)
        self.bio = bio
        
        // 27)
        self._has_password = _has_password
        
        // 28)
        self.email_preferences = email_preferences
        
        // 29)
        self._resume = _resume
        
        // 30)
        self.key = key
        
        // 31)
        self.nickname = nickname
        
        // 32)
        self.employer_sharing = employer_sharing
        
        // 33)
        self._memberships = _memberships
        
        // 34)
        self.zendesk_id = zendesk_id
        
        // 35)
        self._registered = _registered
        
        // 36)
        self.linkedin_url = linkedin_url
        
        // 37)
        self._google_id = _google_id
        
        // 38)
        self._image_url = _image_url
        
        self.emailAddressVal = emailAddressVal
        self._verifiedVal = _verifiedVal
        self._verification_code_sent = _verification_code_sent
     */
    }
    
    
    
}

extension PublicUserDataResponse{
    
    enum PublicUserDataResponseCodingKeys: String,CodingKey {
        enum PublicUserDataResponseEmailCodingKey:String, CodingKey {
                case address = "address"
                case _verified = "_verified"
                case _verification_code_sent = "verification_code_sent"
        }
        
        // 1)
        case last_name = "last_name"
        /*
        // 2)
        case social_accounts = "social_accounts"
        
        // 3)
        case mailing_address = "mailing_address"
        
        // 4)
        case _cohort_keys = "_cohort_keys"
        
        // 5)
        case signature = "signature"
        
        // 6)
        case _stripe_customer_id = "_stripe_customer_id"
        
        // 7)
        case _guard = "guard"
        
        // 8)
        case _facebook_id = "_facebook_id"
        
        // 9)
        case timezone = "timezone"
        
        // 10)
        case site_preferences = "site_preferences"
        
        // 11)
        case occupation = "occupation"
        
        // 12)
        case _image = "_image"
        */
        // 13)
        case first_name = "first_name"
        /*
        // 14)
        case jabber_id = "jabber_id"
        
        // 15)
        case languages = "languages"
        
        // 16)
        case _badges = "_badges"
        
        // 17)
        case location = "location"
        
        // 18)
        case external_service_password = "external_service_password"
        
        // 19)
        case _principals = "_principals"
        
        // 20)
        case _enrollments  = "_enrollments"
        
        // 21)
        case email = "email"
        
        // 22)
        case website_url = "website_url"
        
        // 23
        case external_accounts = "external_accounts"
        
        // 23)
        case coaching_data = "coaching_data"
        
        // 24)
        case tags = "tags"
        
        // 25)
        case _affiliate_profiles = "_affiliate_profiles"
        
        
        // 26)
        case bio = "bio"
        
        // 27)
        case _has_password = "_has_password"
        
        // 28)
        case email_preferences = "email_preferences"
        
        // 29)
        case _resume = "_resume"
        
        // 30)
        case key = "key"
        
        // 31)
        case nickname = "nickname"
        
        // 32)
        case employer_sharing = "employer_sharing"
        
        // 33)
        case _memberships = "_memberships"
        
        // 34)
        case zendesk_id = "zendesk_id"
        
        // 35)
        case _registered = "_registered"
        
        // 36)
        case linkedin_url = "linkedin_url"
        
        // 37)
        case _google_id = "_google_id"
        
        // 38)
        case _image_url = "_image_url"
 */
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PublicUserDataResponseCodingKeys.self)
        let lastName:String = try container.decode(String.self, forKey: .last_name)
        /*let socialAccounts:[Any] = try container.decode([String].self, forKey: .social_accounts)
        let cohort_keys:[Any] = try container.decode([String].self, forKey:._cohort_keys)
        let _badgesVal:[Any] = try container.decode([String].self, forKey: ._badges)
        let _principalVal:[Any] = try container.decode([String].self, forKey: ._principals)
        let _enrollmentsVal:[Any] = try container.decode([String].self, forKey: ._enrollments)
        //let emailValContainer = try  decoder.container(keyedBy: PUDREmailObjectResponse.self)
        let emailVal = try container.decode(PUDREmailObjectResponse.self, forKey: .email)
        let tagsVal:[Any] = try container.decode([String].self, forKey: .tags)
        let _affiliate_profilesVal:[Any] = try container.decode([String].self, forKey: ._affiliate_profiles)
        let _membershipsVal = try container.decode([String].self, forKey: ._memberships)
        let externalAccountsVal = try container.decode([String].self, forKey: .external_accounts)
        let _guard = try container.decode(String.self, forKey: ._guard)
        let mailingAddress:String = try container.decode(String.self, forKey: .mailing_address)
        let signature:String = try container.decode(String.self, forKey: .signature)
        let stripeCustomerId:String = try container.decode(String.self, forKey: ._stripe_customer_id)
        let faceBookId:String = try container.decode(String.self, forKey: ._facebook_id)
        let timeZone:String = try container.decode(String.self, forKey: .timezone)
        let sitePref:String = try container.decode(String.self, forKey: .site_preferences)
        let occupation:String = try container.decode(String.self, forKey: .occupation)
        let imageVal:String = try container.decode(String.self, forKey: ._image)
        */
        let firstName:String = try container.decode(String.self, forKey: .first_name)
        /*let jabberId:String = try container.decode(String.self, forKey: .jabber_id)
        let languagesVal:String = try container.decode(String.self, forKey: .languages)
        let locationVal:String = try container.decode(String.self, forKey: .location)
        let externalServicePw:String = try container.decode(String.self, forKey: .external_service_password)
        let websiteUrl:String = try container.decode(String.self, forKey: .website_url)
        let bioVal:String = try container.decode(String.self, forKey: .bio)
        let coachingData:String = try container.decode(String.self, forKey: .coaching_data)
        let hasPw:Bool = try container.decode(Bool.self, forKey: ._has_password)
        let emailPref:String = try container.decode(String.self, forKey: .email_preferences)
        let resumeVal:String = try container.decode(String.self, forKey: ._resume)
        let keyVal:String = try container.decode(String.self, forKey: .key)
        let nickNameVal:String = try container.decode(String.self, forKey: .nickname)
        let employerSharing:Bool = try container.decode(Bool.self, forKey: .employer_sharing)
        let zenDeskVal:String = try container.decode(String.self, forKey: .zendesk_id)
        let registered:Bool = try container.decode(Bool.self, forKey: ._registered)
        let linkedinVal:String = try container.decode(String.self, forKey: .linkedin_url)
        let googleId:String = try container.decode(String.self, forKey: ._google_id)
        let imageUrlVal:String = try container.decode(String.self, forKey: ._image_url)
        
        let emailValContainer = try container.nestedContainer(keyedBy: PublicUserDataResponseCodingKeys.PublicUserDataResponseEmailCodingKey.self, forKey: .email)
        let emailAddressVal = try emailValContainer.decode(String.self, forKey: PublicUserDataResponseCodingKeys.PublicUserDataResponseEmailCodingKey.address)
        let _verifiedVal = try emailValContainer.decode(Bool.self, forKey: PublicUserDataResponseCodingKeys.PublicUserDataResponseEmailCodingKey._verified)
        let _verification_code_sentVal = try emailValContainer.decode(Bool.self, forKey: PublicUserDataResponseCodingKeys.PublicUserDataResponseEmailCodingKey._verification_code_sent)
        */
        self.init(last_name: lastName,/* social_accounts: socialAccounts, mailing_address: mailingAddress, _cohort_keys: cohort_keys, signature: signature, _stripe_customer_id: stripeCustomerId, _guard: _guard,_facebook_id: faceBookId, timezone: timeZone, site_preferences: sitePref, occupation: occupation, _image: imageVal, */first_name: firstName/*, jabber_id: jabberId, languages: languagesVal, _badges:_badgesVal, location: locationVal, external_service_password: externalServicePw, _principals:_principalVal,_enrollments:_enrollmentsVal, email:emailVal, website_url: websiteUrl,external_accounts: externalAccountsVal, bio: bioVal, coaching_data: coachingData, tags: tagsVal, _affiliate_profiles:_affiliate_profilesVal, _has_password: hasPw, email_preferences: emailPref, _resume: resumeVal, key: keyVal, nickname: nickNameVal, employer_sharing: employerSharing,_memberships:_membershipsVal, zendesk_id: zenDeskVal, _registered: registered, linkedin_url: linkedinVal, _google_id: googleId, _image_url: imageUrlVal, emailAddressVal: emailAddressVal, _verifiedVal:_verifiedVal, _verification_code_sent: _verification_code_sentVal*/)
        
    }
    
   public func encode(to encoder: Encoder) throws {
        let containter = try encoder.container(keyedBy: PublicUserDataResponseCodingKeys.self)
    }
}
