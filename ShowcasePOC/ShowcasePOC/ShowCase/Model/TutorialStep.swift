//
// TutorialStep.swift
// ShowcasePOC
//
// Created by MANAS VIJAYWARGIYA on 09/07/25.
// ------------------------------------------------------------------------
// Copyright © 2025 Blacenova. All rights reserved.
// ------------------------------------------------------------------------
//
    

import SwiftUI

enum TutorialStep: Int, CaseIterable, Identifiable {
  case step1 = 0
  case step2
  case step3
  case step4
  case step5
  case step6
  case step7
  case step8
  case step9
  case step10
  
  var id: Int { rawValue }
  
  var titleKey: String {
    switch self {
      case .step1: return "tutorial_tooltip_step_1_title"
      case .step2: return "tutorial_tooltip_step_2_title"
      case .step3: return "tutorial_tooltip_step_3_title"
      case .step4: return "tutorial_tooltip_step_4_title"
      case .step5: return "tutorial_tooltip_step_5_title"
      case .step6: return "tutorial_tooltip_step_6_title"
      case .step7: return "tutorial_tooltip_step_7_title"
      case .step8: return "tutorial_tooltip_step_8_title"
      case .step9: return "tutorial_tooltip_step_9_title"
      case .step10: return "tutorial_tooltip_step_10_title"
    }
  }
  
  var subtitleKey: String {
    switch self {
      case .step1: return "tutorial_tooltip_step_1_description"
      case .step2: return "tutorial_tooltip_step_2_description"
      case .step3: return "tutorial_tooltip_step_3_description"
      case .step4: return "tutorial_tooltip_step_4_description"
      case .step5: return "tutorial_tooltip_step_5_description"
      case .step6: return "tutorial_tooltip_step_6_description"
      case .step7: return "tutorial_tooltip_step_7_description"
      case .step8: return "tutorial_tooltip_step_8_description"
      case .step9: return "tutorial_tooltip_step_9_description"
      case .step10: return "tutorial_tooltip_step_10_description"
    }
  }
  
  var countKey: String {
    switch self {
      case .step1: return "tutorial_tooltip_step_1_count"
      case .step2: return "tutorial_tooltip_step_2_count"
      case .step3: return "tutorial_tooltip_step_3_count"
      case .step4: return "tutorial_tooltip_step_4_count"
      case .step5: return "tutorial_tooltip_step_5_count"
      case .step6: return "tutorial_tooltip_step_6_count"
      case .step7: return "tutorial_tooltip_step_7_count"
      case .step8: return "tutorial_tooltip_step_8_count"
      case .step9: return "tutorial_tooltip_step_9_count"
      case .step10: return "tutorial_tooltip_step_10_count"
    }
  }
}

/*
 .showCase(order: 0, title: LocalizationManager.shared.localizedString(forKey: "charging_or_fueling"), subtitle: LocalizationManager.shared.localizedString(forKey: "choose_btw_charging_or_fueling"), cornerRadius: 10, style: .continuous)
 .showCase(order: 1, title: LocalizationManager.shared.localizedString(forKey: "filter_your_search"), subtitle: LocalizationManager.shared.localizedString(forKey: "quickly_find_charge_points"), cornerRadius: 45, style: .continuous)
 .showCase(order: 2, title: LocalizationManager.shared.localizedString(forKey: "scan_to_start_charging"), subtitle: LocalizationManager.shared.localizedString(forKey: "scan_qr_code"), cornerRadius: 45, style: .continuous)
 .showCase(order: 3, title: LocalizationManager.shared.localizedString(forKey: "fav"), subtitle: LocalizationManager.shared.localizedString(forKey: "fav_stations"), cornerRadius: 45, style: .continuous)
 .showCase(order: 4, title: LocalizationManager.shared.localizedString(forKey: "map_legends"), subtitle: LocalizationManager.shared.localizedString(forKey: "check_map_legend"), cornerRadius: 45, style: .continuous)
 .showCase(order: 5, title: LocalizationManager.shared.localizedString(forKey: "personal_info"), subtitle: LocalizationManager.shared.localizedString(forKey: "check_profile"), cornerRadius: 10, style: .continuous)
 .showCase(order: 6, title: LocalizationManager.shared.localizedString(forKey: "my_map"), subtitle: LocalizationManager.shared.localizedString(forKey: "check_routes"), cornerRadius: 10, style: .continuous)
 .showCase(order: 7, title: LocalizationManager.shared.localizedString(forKey: "location_enable"), subtitle: LocalizationManager.shared.localizedString(forKey: "check_location_tag"), cornerRadius: 10, style: .continuous)
 .showCase(order: 8, title: LocalizationManager.shared.localizedString(forKey: "account_management"), subtitle: LocalizationManager.shared.localizedString(forKey: "to_manage_user_data"), cornerRadius: 45, style: .continuous)
 .showCase(order: 9, title: LocalizationManager.shared.localizedString(forKey: "my_vehicle"), subtitle: LocalizationManager.shared.localizedString(forKey: "add_your_vehicle"), cornerRadius: 0, style: .continuous)
 */
