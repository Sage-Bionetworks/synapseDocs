---
title: "User Accounts"
layout: article
excerpt: Create your Synapse user account and manage your profile.  
category: admin-and-settings
---

Anyone can browse public content on the Synapse web site, but in order to download and create content you will need to register for an account using an email address. You will receive an email message for verification to complete the registration process.

<a href="https://www.synapse.org/register" class="btn btn-primary">Register</a>

Certain actions in Synapse require additional steps, such as Certification or Validation. Explore our [accounts, certification and profile validation]({{ site.baseurl }}{% link _articles/accounts_certified_users_and_profile_validation.md %}) page to find out more information on the different levels of users.

## Managing Your Profile

Visit your [Profile Page](https://www.synapse.org/#!Profile:v), which can be accessed by clicking your name in the top right corner and selecting "Profile" from the menu. From there, you can click on "Edit Profile" in order to take any of the following actions:

* Change your Synapse user name
* Add or edit your first and last names as shown
* Add or edit additional (optional) information, such as your affiliation or title
* Upload an (optional) profile picture
* Include a brief (optional) biography
* Link your ORCID credentials

You can also find a link to edit your profile under [Settings](https://www.synapse.org/#!Profile:v/settings), which can be accessed by clicking your name in the top right corner and selecting "Settings" from the menu.

{% include important.html content="Do not reuse passwords from other sites. We recommend generating a unique password and using a secure password manager to protect your Synapse account." %}

## Changing Your Settings

`Settings` include your password, your preferred date/time format, and your Synapse API key. You can also visit your settings page to add more than one email address to your Synapse account.

### Adding Additional Email Addresses

Your Synapse account can have multiple email addresses associated with it. For each email, you will add it to your Synapse account and go through the email validation process. A notification will be sent to the chosen email address with a confirmation link. Follow the link to confirm ownership of the email account.

### Adding Google Email Addresses to Enable SSO

Synapse integrates with Google's Single Sign On (SSO) using OAuth 2.0, allowing you to sign in with your Google credentials. If you are already signed in to Google in your web browser, then you can sign in to Synapse without entering a password at all, once you have connected your Google account.

If you wish to use this feature, then you should create your Synapse account using as your email address the same address which you have registered with Google, or add a Google address as a secondary email. (This might be a Gmail address, an institutional email address configured to be used with [Google Suite](https://gsuite.google.com), or other). However, if you have created an account with an email address that is **not** recognized by Google, SSO can still be enabled by associating a second, Google-recognized email address with your account, as described below. By adding your Google-recognized email address to your Synapse account you will enable SSO. Go go to your accounts settings by clicking your name in the upper right of any Synapse page (you must be logged in to Synapse) and select "Settings". Scroll down to email section of your account settings and add your Google-recognized email address (as shown in [Gmail](https://mail.google.com) ) to your account.

Sometimes it is not obvious what your Google-recognized email is; you may have more than one alias that people can you to send you a message, all messages landing in your email inbox. One way to check is to open [Gmail](https://mail.google.com) in your browser and click on your photo or icon in in the upper right corner. The dialog that pops up will show the correct address.

Sign out of Synapse and sign back in using Google by clicking "Sign in with Google" on the Synapse home page.

If you use your Google credentials to create an account with Synapse, use your [API key]({{ site.baseurl }}{% link _articles/user_profiles.md %}#api-key) to login to Synapse from the programmatic clients. 

### API Key

Your Synapse API key is *highly recommended* to be used to login to Synapse from the [command line](https://python-docs.synapse.org/build/html/CommandLineClient.html#login), [Python](https://python-docs.synapse.org/build/html/index.html#connecting-to-synapse) or [R clients](https://r-docs.synapse.org/articles/manageSynapseCredentials.html) in place of a password. API keys are almost always more secure than a password and need to be protected similarly to a password.

To find your API key, from your user icon in the top right corner, select **Profile** and **Settings**. Your Synapse API key is available in the box furthest to the bottom of Settings and can be made visible with **Show API Key**.

### Notification Email

Synapse sends platform notifications via email, but does so only to the single email address you have selected to be your `Primary` or `Notification Email`. You can manage this in `Settings`. This is the same email that Synapse will use to pass on messages sent to your `username@synapse.org` email address by other users, such as `Mentions` in discussion forums or direct emails sent by other users to you.

### Deactivating Your Account

Please contact us to deactivate your Synapse account.

# See Also

[Accounts, Certification and Profile Validation]({{ site.baseurl }}{% link _articles/accounts_certified_users_and_profile_validation.md %}), [Discussion]({{ site.baseurl }}{% link _articles/discussion.md %})
