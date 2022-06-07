import 'package:get/route_manager.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        //English
        "en": {
          "english": "English",
          "turkish": "Turkish",
          "loading": "Loading...",
          "verificationEmailHasBeenSentPleaseConfirmYourEmail":
              "Verification email has been sent. Please confirm your email.",
          "gotIt": "Got it",
          "emailHasBeenSent": "Email has been sent",
          "existing": "Existing",
          "new": "New",
          "emailAddress": "Email Address",
          "password": "Password",
          "login": "LOGIN",
          "forgotPassword": "Forgot Password?",
          "or": "Or",
          "name": "Name",
          "confirmation": "Confirmation",
          "signUp": "SIGN UP",
          "passwordsMustBeTheSame": "Passwords must be the same",
          "allFieldsMustBeFilled": "All fields must be filled",
          "emailFieldMustBeFilled": "Email field must be filled",
          "passwordResetEmailHasBeenSentToYourEmail":
              "Password reset email has been sent to your email.",
          "enterTheEmailAddressAssociatedWithYourAccount":
              "Enter the email address associated with your account",
          "weWillEmailYouALinkToResetYourPassword":
              "We will email you a link to reset your password",
          "enterEmailAddress": "Enter Email Address",
          "send": "Send",
          "adFreeUse": "AD-FREE USE",
          "youCanTurnOffAdsAndMeetMorePeople":
              "You can turn off ads and meet more people!",
          "bestValueSave": "Best Value - Save 75%",
          "lifetime": "Lifetime",
          "payOnce": "(Pay once)",
          "upgradeNow": "Upgrade Now",
          "youveToGetVipToBlockAds": "You've to get VIP to block ads!",
          "getSpeakmatchVip": "Get Speakmatch VIP",
          "speakmatchVip": "Speakmatch VIP",
          "editProfile": "Edit Profile",
          "changePhoto": "Change Photo",
          "settings": "Settings",
          "contactUs": "Contact Us",
          "helpAndSupport": "Help and Support",
          "legal": "Legal",
          "privacyPolicy": "Privacy Policy",
          "share": "Share",
          "inviteYourFriends": "Invite Your Friends",
          "signOut": "Sign Out",
          "version": "Version 1.0.6 (Release)",
          "deleteAccount": "Delete Account",
          "cancel": "Cancel",
          "delete": "Delete",
          "areYouSureWantToDeleteYourAccount":
              "Are you sure want to delete your account?",
          "pleaseRethinkYourDecisionBecauseYouWillNotBeAbleToUndoThisAction":
              "Please, rethink your decision because you will not be able to undo this action!",
          "passwordIsRequired": "password is required",
          "changePersonalInformation": "Change Personal Information",
          "changePassword": "Change Password",
          "changeEmail": "Change Email",
          "changesSaved": "Changes saved.",
          "male": "Male",
          "female": "Female",
          "nameFieldMustBeFilled": "Name field must be filled.",
          "passwordHasBeenChanged": "Password has been changed.",
          "currentPassword": "Current Password",
          "newPassword": "New Password",
          "reNewPassword": "Re-NewPassword",
          "oldPasswordAndNewPasswordCannotBeTheSame":
              "Old password and new password cannot be the same",
          "emailHasBeenChanged": "Email has been changed.",
          "newEmail": "New Email",
          "notifications": "Notifications",
          "thereIsNothingHere": "There is nothing here",
          "call": "Call",
          "andMeetNewPeople": "and meet new people!",
          "adsOn": "Ads On",
          "adsOff": "Ads Off",
          "showProfile": "Show Profile",
          "hideProfile": "Hide Profile",
          "calling": "Calling...",
          "connecting": "Connecting...",
          "online": "Online",
          "offline": "Offline",
          "vipMembershipRequired": "Vip Membership Required",
          "youMustHaveAVipMembershipToBeAbleToTurnOffAds":
              "You must have a VIP membership to be able to turn off ads",
          "successful": "Successful!",
          "error": "Error!",
          "somethingWentWrong": "Something Went Wrong!",
          "language": "Language",
          "changeLanguage": "Change Language"
        },
        //Turkish
        "tr": {
          "english": "İngilizce",
          "turkish": "Türkçe",
          "loading": "Yükleniyor...",
          "verificationEmailHasBeenSentPleaseConfirmYourEmail":
              "Doğrulama e-postası gönderildi. Lütfen e-postanızı onaylayın.",
          "gotIt": "Anladım",
          "emailHasBeenSent": "Mail gönderildi",
          "existing": "Giriş",
          "new": "Yeni",
          "emailAddress": "E-posta Adresi",
          "password": "Şifre",
          "login": "GİRİŞ YAP",
          "forgotPassword": "Şifrenizi mi unuttunuz?",
          "or": "Veya",
          "name": "İsim",
          "confirmation": "Şifre Tekrar",
          "signUp": "KAYIT OL",
          "passwordsMustBeTheSame": "Şifreler aynı olmalıdır",
          "allFieldsMustBeFilled": "Tüm alanlar doldurulmalı",
          "emailFieldMustBeFilled": "E-posta alanı doldurulmalı",
          "passwordResetEmailHasBeenSentToYourEmail":
              "Şifre sıfırlama e-postası gönderildi.",
          "enterTheEmailAddressAssociatedWithYourAccount":
              "Hesabınızla ilişkili e-posta adresini girin",
          "weWillEmailYouALinkToResetYourPassword":
              "Şifrenizi sıfırlamak için size bir link göndereceğiz.",
          "enterEmailAddress": "E-posta adresini gir",
          "send": "Gönder",
          "adFreeUse": "Reklamsız Kullan!",
          "youCanTurnOffAdsAndMeetMorePeople":
              "Reklamları kapatabilir ve daha fazla insanla tanışabilirsiniz!",
          "bestValueSave": "En İyi Fiyat - %75",
          "lifetime": "Ömür boyu",
          "payOnce": "(Tek sefer öde)",
          "upgradeNow": "Hemen Yükselt",
          "youveToGetVipToBlockAds":
              "Reklamları engellemek için VIP üyelik almanız gerekir!",
          "getSpeakmatchVip": "Speakmatch VIP Al",
          "speakmatchVip": "Speakmatch VIP",
          "editProfile": "Profili Düzenle",
          "changePhoto": "Fotoğrafı değiştir",
          "settings": "Ayarlar",
          "contactUs": "Bizimle İletişime Geçin",
          "helpAndSupport": "Yardım ve Destek",
          "legal": "Yasal",
          "privacyPolicy": "Gizlilik Politikası",
          "share": "Paylaş",
          "inviteYourFriends": "Arkadaşlarını Davet Et",
          "signOut": "Oturumu Kapat",
          "version": "Sürüm 1.0.6 (release)",
          "deleteAccount": "Hesabı Sil",
          "cancel": "İptal",
          "delete": "Sil",
          "areYouSureWantToDeleteYourAccount":
              "Hesabınızı silmek istediğinizden emin misiniz?",
          "pleaseRethinkYourDecisionBecauseYouWillNotBeAbleToUndoThisAction":
              "Lütfen, kararınızı yeniden düşünün, çünkü bu işlemi geri alamazsınız!",
          "passwordIsRequired": "Şifre gereklidir",
          "changePersonalInformation": "Kişisel Bilgileri Değiştir",
          "changePassword": "Şifre Değiştir",
          "changeEmail": "E-posta Değiştir",
          "changesSaved": "Değişiklikler kaydedildi.",
          "male": "Erkek",
          "female": "Kadın",
          "nameFieldMustBeFilled": "İsim alanı doldurulmalıdır.",
          "passwordHasBeenChanged": "Şifre değiştirildi.",
          "currentPassword": "Mevcut Şifre",
          "newPassword": "Yeni Şifre",
          "reNewPassword": "Yeni Şifre Tekrar",
          "oldPasswordAndNewPasswordCannotBeTheSame":
              "Eski şifre ve yeni şifre aynı olamaz",
          "emailHasBeenChanged": "E-posta değiştirildi.",
          "newEmail": "Yeni E-posta",
          "notifications": "Bildirimler",
          "thereIsNothingHere": "Burada hiçbir şey yok",
          "call": "Ara",
          "andMeetNewPeople": "ve yeni insanlarla tanış!",
          "adsOn": "Reklamlar Açık",
          "adsOff": "Reklamlar Kapalı",
          "showProfile": "Profili Göster",
          "hideProfile": "Profili Gizle",
          "calling": "Aranıyor...",
          "connecting": "Bağlanıyor...",
          "online": "Çevrimiçi",
          "offline": "Çevrimdışı",
          "vipMembershipRequired": "Vip Üyelik Gerekli",
          "youMustHaveAVipMembershipToBeAbleToTurnOffAds":
              "Reklamları kapatabilimek için VIP üyeliğe sahip olman gerekiyor",
          "successful": "Başarılı!",
          "error": "Hata!",
          "somethingWentWrong": "Bir şeyler yanlış gitti!",
          "language": "Dil",
          "changeLanguage": "Dili Değiştir"
        }
      };
}