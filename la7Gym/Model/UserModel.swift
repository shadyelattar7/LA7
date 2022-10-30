//
//  UserModel.swift
//  la7Gym
//
//  Created by Mohamed on 09/08/2021.
//

import Foundation

struct UserModel: Codable {
    let id: String?
    let created: String?
    let updated: String?
    let deleted: String?
    let creatorid: String?
    let email: String?
    let first_name: String?
    let last_name: String?
    let phone: String?
    let position: String?
    let clientid: String?
    let account_owner: String?
    let primary_admin: String?
    let avatar_directory: String?
    let avatar_filename: String?
    let type: String?
    let status: String?
    let role_id: String?
    let last_seen: String?
    let theme: String?
    let last_ip_address: String?
    let social_facebook: String?
    let social_twitter: String?
    let social_linkedin: String?
    let social_github: String?
    let social_dribble: String?
    let pref_language: String?
    let pref_email_notifications: String?
    let pref_leftmenu_position: String?
    let pref_statspanel_position: String?
    let pref_filter_own_tasks: String?
    let pref_filter_own_projects: String?
    let pref_filter_show_archived_projects: String?
    let pref_filter_show_archived_tasks: String?
    let pref_filter_show_archived_leads: String?
    let pref_filter_own_leads: String?
    let pref_view_tasks_layout: String?
    let pref_view_leads_layout: String?
    let forgot_password_token: String?
    let forgot_password_token_expiry: String?
    let force_password_change: String?
    let notifications_system: String?
    let notifications_new_project: String?
    let notifications_projects_activity: String?
    let notifications_billing_activity: String?
    let notifications_new_assignement: String?
    let notifications_leads_activity: String?
    let notifications_tasks_activity: String?
    let notifications_tickets_activity: String?
    let thridparty_stripe_customer_id: String?
    let dashboard_access: String?
    let welcome_email_sent: String?
    let membership_id: String?
    let gender: String?
    let weight: String?
    let height: String?
    let notes: String?
    let subscription_end_date: String?
}
