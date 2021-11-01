import 'package:get/get.dart';

class LocaleString extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>
      {
        'en_US': {
        'home': 'Home',
        'sendandreceivegift' : 'Send/Receive Gifts',
        'projectfunding' : 'Project Funding',
        'donations' : 'Donations',
        'events' : 'Events',
        'tickets' : 'Tickets',
        'notification' : 'Notification',
        },

        'ar_SA': {
          'home': 'الصفحة الرئيسية',
          'sendandreceivegift' : 'إرسال / استقبال الهدايا',
          'projectfunding' : 'تمويل المشاريعا',
          'donations' : 'التبرعات',
          'events' : 'الأحداث',
          'tickets' : 'تذاكر',
          'notification' : 'تنبيه',
        },
      };
}