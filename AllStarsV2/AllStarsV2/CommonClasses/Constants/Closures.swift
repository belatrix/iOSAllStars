//
//  Closures.swift
//  AllStarsV2
//
//  Created by Kenyi Rodriguez Vergara on 20/07/17.
//  Copyright © 2017 Kenyi Rodriguez Vergara. All rights reserved.
//

import UIKit

typealias User                  = (_ user : UserBE) -> Void
typealias UserSession           = (_ userSession : SessionBE) -> Void
typealias ErrorResponse         = (_ error : ErrorResponseBE) -> Void
typealias AlertInformation      = (_ title : String, _ message : String) -> Void
typealias Locations             = (_ arrayLocations : [LocationBE]) -> Void
typealias Categories            = (_ arrayCategories : [CategoryBE]) -> Void
typealias KeyWords              = (_ arrayKeyWords : [KeywordBE]) -> Void
typealias KeyWord               = (_ keyWord : KeywordBE) -> Void
typealias Stars                 = (_ arrayStars : [StarUserBE]) -> Void
typealias Star                  = (_ star : StarUserBE) -> Void
typealias Achievements          = (_ arrayAchievements : [AchievementBE]) -> Void
typealias Contacts              = (_ arrayContacts : [UserBE], _ urlNextPage: String) -> Void
typealias Ranking               = (_ arrayUsersRanking : [UserBE]) -> Void
typealias Events                = (_ arrayEvents : [EventBE], _ urlNextPage: String) -> Void
typealias Event                 = (_ event : EventBE) -> Void
typealias Activities            = (_ activities : [ActivityEventBE]) -> Void
typealias Success               = (_ isSuccess : Bool) -> Void
typealias AppConfiguration      = (_ appConfiguration : AppInformationBE) -> Void
