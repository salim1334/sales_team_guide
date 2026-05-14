import 'package:alarm_sales_guide/data/models/user_model.dart';
import 'package:alarm_sales_guide/data/models/call_script_group_model.dart';
import 'package:alarm_sales_guide/data/models/call_script_model.dart';
import 'package:alarm_sales_guide/data/models/ad_template_group_model.dart';
import 'package:alarm_sales_guide/data/models/ad_template_model.dart';

class SeedData {
  static List<UserModel> get users => [
    UserModel(
      id: 1,
      name: 'Salim',
      email: 'salim@alarmtech.com',
      password: '2026', // Storing in plain text as requested for placeholder
      createdAt: DateTime.now().toIso8601String(),
    ),
    UserModel(
      id: 2,
      name: 'Malik',
      email: 'malik@alarmtech.com',
      password: '2026',
      createdAt: DateTime.now().toIso8601String(),
    ),
  ];

  static List<CallScriptGroupModel> get callScriptGroups => [
    CallScriptGroupModel(
      id: 1,
      title: 'Qualification',
      titleAm: 'የንግድ ሁኔታቸውን መለየት',
      icon: '1',
      sortOrder: 1,
    ),
    CallScriptGroupModel(
      id: 2,
      title: 'Pain Point Discovery',
      titleAm: 'ዋናውን የችግር ነጥቦችን መለየት',
      icon: '2',
      sortOrder: 2,
    ),
    CallScriptGroupModel(
      id: 3,
      title: 'Workflow Questions',
      titleAm: 'የአሁኑን አሰራር መረዳት',
      icon: '3',
      sortOrder: 3,
    ),
    CallScriptGroupModel(
      id: 4,
      title: 'Solution Approach',
      titleAm: 'የመፍትሄ አቀራረብ',
      icon: '4',
      sortOrder: 4,
    ),
  ];

  static List<CallScriptModel> get callScripts => [
    // Group 1: Qualification
    CallScriptModel(
      groupId: 1,
      bodyAm: 'ስለ ድርጅትዎ የንግድ አይነት ጥቂት ቢነግሩኝ ደስ ይለኛል፤ ሱቅ ነው (ሸቀጥ) ወይስ ጅምላ ሽያጭ?',
      tag: '',
      sortOrder: 1,
    ),
    CallScriptModel(
      groupId: 1,
      bodyAm: 'ስንት መጋዘኖች እና ሱቆች ነው ያሎት?',
      tag: '',
      sortOrder: 2,
    ),
    CallScriptModel(
      groupId: 1,
      bodyAm: 'ስንት ሰራተኛ አሎት?',
      tag: '',
      sortOrder: 3,
    ),
    // Group 2: Pain Point Discovery
    CallScriptModel(
      groupId: 2,
      bodyAm: 'በአሁኑ ሰዓት በስራዎ ላይ በጣም አስቸጋሪ የሆነብዎት እና ብዙ ሰአትዎን እያባከነብዎ ያለው ነገር ምንድን ነው? የእቃ ቁጥጥር፣ ዱቤ አያያዝ፣ ገቢና ዎጪ ገንዘብን መቆጣጠር ወይስ ጠቅላላ ሽያጭና ግዥን መከታተል',
      tag: '',
      sortOrder: 1,
    ),
    // Group 3: Workflow Questions
    CallScriptModel(
      groupId: 3,
      bodyAm: 'እስካሁን ስራዎን ለመቆጣጠር ምን አይነት ዘዴ እየተጠቀሙ ነው? (ደብተር፣ ኤክሴል ወይስ ሌላ ሶፍትዌር?)',
      tag: '',
      sortOrder: 1,
    ),
    CallScriptModel(
      groupId: 3,
      bodyAm: 'በደብተር/በኤክሴል ለመመዝገብ ምን ያህል ሰአት ይፈጅቦታል?',
      tag: '',
      sortOrder: 2,
    ),
    // Group 4: Solution Approach
    CallScriptModel(
      groupId: 4,
      bodyAm: 'ይሄ ችግር በስራዎ ላይ ጫና እየፈጠረ እንደሆነ ግልጽ ነው። ስራዎን ሊያስፋፉበት እና ለራስዎ፣ ለቤተሰብዎ ሊጠቀሙብት የሚገባውን ሰአት እየተሻማ ነው።',
      tag: 'Understanding',
      sortOrder: 1,
    ),
    CallScriptModel(
      groupId: 4,
      bodyAm: 'እኛ ጋር ካሉ ደንበኞች መካከል እንደርስዎ [ችግሩን ጥቀስ] የነበረባቸው ነበሩ፤ አሁን ግን በሲስተሙ [መፍትሄውን ጥቀስ] በዚ መልኩ ችግሩን ፈቶላቸዋል።',
      tag: 'Connecting',
      sortOrder: 2,
    ),
    CallScriptModel(
      groupId: 4,
      bodyAm: 'ስለሲስተሙ ተጨማሪ ማብራሪያ የሚፈልጉ ከሆነ ወይም ቀጣዩን ስቴፕ የሚያሳይ ቪዲዎ እልክሎታለው።',
      tag: 'Closing',
      sortOrder: 3,
    ),
    CallScriptModel(
      groupId: 4,
      bodyAm: 'ይህ ሲስተም ለርስዎ ስራ እንደሚሆን ለማሳየት በአካል መጥተን ዴሞ ብናሳዮት ይሻላል? ወይስ መጀመሪያ ቪዲዮውን ልላክሎት?',
      tag: 'Choice',
      sortOrder: 4,
    ),
  ];

  static List<AdTemplateGroupModel> get adTemplateGroups => [
    AdTemplateGroupModel(
      id: 1,
      name: 'Group 1: Retailer (Stock & Theft)',
      description: 'Daily Amharic messaging templates for Retailers focusing on Stock & Theft.',
      sortOrder: 1,
    ),
    AdTemplateGroupModel(
      id: 2,
      name: 'Group 2: Single Shop + Warehouse (ERP/Sync)',
      description: 'Daily Amharic messaging templates focusing on single shop and warehouse sync.',
      sortOrder: 2,
    ),
    AdTemplateGroupModel(
      id: 3,
      name: 'Group 3: Multi-Shop/Warehouse (Multi-Location ERP)',
      description: 'Daily Amharic messaging templates focusing on multi-shop monitoring.',
      sortOrder: 3,
    ),
    AdTemplateGroupModel(
      id: 4,
      name: 'Group 4: Retailer (Credit, Cashflow, Expenses)',
      description: 'Daily Amharic messaging templates focusing on credit, cashflow, and expenses.',
      sortOrder: 4,
    ),
  ];

  static List<AdTemplateModel> get adTemplates => [
    // Group 1
    AdTemplateModel(groupId: 1, dayNumber: 1, bodyAm: 'ዛሬ ማታ ሱቅዎን ሲዘጉ፣ በሱቅዎ ውስጥያለው ዕቃ እና ደብተርዎ ላይ የተመዘገበው ቁጥር ተመሳሳይ እንደሆነ እርግጠኛ ነዎት?'),
    AdTemplateModel(groupId: 1, dayNumber: 2, bodyAm: 'በየቀኑ አንድ ወይም ሁለት ዕቃዎች ቢጠፉ በወሩ መጨረሻ ላይ ድምሩ ስንት ሊሆን እንደሚችል አስበው ያውቃሉ?'),
    AdTemplateModel(groupId: 1, dayNumber: 3, bodyAm: 'ሱቅዎ ውስጥ እቃ ቢጠፋ ወይም ቢሰረቅ እንዴት ነው ማረጋገጥ የሚችሉት? በሰራተኛ እምነት ላይ ብቻ ነው ተማምነው ነው እየሰሩ ያሉት?'),
    AdTemplateModel(groupId: 1, dayNumber: 4, bodyAm: 'በደብተር በሚመዘግቡበት ሰአት የሚፈጠሩ ስህተቶች ትርፍዎን እየወሰዱ እንደሆነስ ስንት ጊዜ ተሰምቶዎታል?'),
    AdTemplateModel(groupId: 1, dayNumber: 5, bodyAm: 'ለአንድ ቀን እንኳን ወጣ ብለው የሚፈልጉበት ቦታ ለማሳለፍ ወይም ቤትዎ ረፍት ማድረግ ቢፈልጉ ሱቅ ውስጥ ያለውን እንቅስቃሴ እና ሂደት እንዴት ማወቅ ይችላሉ?'),
    AdTemplateModel(groupId: 1, dayNumber: 6, bodyAm: 'ዕቃ ሲረከቡና ሲሸጡ በደብተር ላይ የሚሰሩ ትናንሽ ስህተቶች መጨረሻቸው ትርፍዎን መቀነስ ከዛም ካለፈ ደግሞ ወደኪሳራ ሊዎስዱ እንደሚችሉ አስበው ያውቃሉ?'),
    AdTemplateModel(groupId: 1, dayNumber: 7, bodyAm: 'በቀን 100 ብር የሚገመት ዕቃ \'ጠፋ\' ቢባል፣ በዓመት 36,000 ብር ኪሳራ መሆኑን አስበውት ያውቃሉ? እንደማይጠፋ በምን እርግጠኛ መሆን ይችላሉ?'),
    AdTemplateModel(groupId: 1, dayNumber: 8, bodyAm: 'የዕቃዎ ዋጋ ሲጨምር ሰራተኛዎ ባለማወቅ ወይም ረስተው በድሮው ዋጋ ሸጠው ትርፍ ያጡበት ቀን ስንት ነው? ዋጋው በተቀያየረ ቁጥር ማሳዎቅ አለብዎ?'),
    AdTemplateModel(groupId: 1, dayNumber: 9, bodyAm: 'ሰራተኛዎ \'እቃው አልቋል\' ሲልዎት፣ በትክክለኛው ዋጋ ተሽጦ እንዳለቀ እና ሁሉም እቃ በማሃል ምንም ሳይጠፋ እንደተሸጠ እንዴት ነው የሚያረጋግጡት?'),
    AdTemplateModel(groupId: 1, dayNumber: 10, bodyAm: 'የዓመት መጨረሻ ቆጠራ ሲያደርጉ ደብተርዎ ላይያለው እና ሱቅዎ ውስጥ ያለው እየተለያየቦት ተቸግረዋል?'),
    AdTemplateModel(groupId: 1, dayNumber: 11, bodyAm: 'ንግድዎ በትክክል እንዲመራ እና ግልጽነት እንዲኖረው ቁጥጥር ወሳኝ ነው። ግን የተለመደው ቁጥጥሩ ደግሞ አድካሚ እና አሰልች ነው፣ ሌላ የተሻለ እና አዋጪ መንገድ ይኖር ይሆን ብለው ጠይቀው ያውቃሉ?'),
    AdTemplateModel(groupId: 1, dayNumber: 12, bodyAm: 'በተለመደው አሰራር የሚመጣን ኪሳራን "የስራ ባህሪ ነው" ብለው ተቀብለውታል ወይስ መፍትሄ እየፈለጉለት ነው?'),
    AdTemplateModel(groupId: 1, dayNumber: 13, bodyAm: 'ሱቅ ሳይሄዱ፣ ዛሬ ምን ያህል እቃ እንደተሸጠ እና ምን እንደቀረ በስልክዎ ማየት ቢችሉ ኖሮ ስራዎ ምን ያህል ይቀል ነበር?'),
    AdTemplateModel(groupId: 1, dayNumber: 14, bodyAm: 'እስከዛሬ የነበረው አሰራር አድካሚ፣ አሰልቺ እና የማያዋጣ ነበር። አሁን ግን \'Alarm Stock\' ከመጣ በኋላ አንዲት እርሳስ ወይም አንድ ብር እንኳ ብትጠፋ በስልኮ ማወቅ ይችላሉ። ንግድዎን ለመታደግ እና ትርፋማ ለማድረግ ይሞክሩት።'),
    
    // Group 2
    AdTemplateModel(groupId: 2, dayNumber: 1, bodyAm: 'መጋዘንዎ ውስጥ ያለው ዕቃ በትክክል ሱቅዎ ውስጥ ካለው የእቃ ዝርዝር ደብተር ጋር ተመሳሳይ ነው? ወይስ ዕቃው መጋዘን እያለ \'የለም\' ብለው ደንበኛ ይመልሳሉ? አቃውስ መጋዘን መኖሩን ለማረጋገጥ መጋዘን ሂዶ አቃውን መፈለግ ግዴታ ነው?'),
    AdTemplateModel(groupId: 2, dayNumber: 2, bodyAm: 'ከመጋዘን ወደ ሱቅ ዕቃ ሲጓጓዝ መሃል ላይ የሚጠፋ ዕቃ እንዳይኖር እንዴት ነው የሚቆጣጠሩት?'),
    AdTemplateModel(groupId: 2, dayNumber: 3, bodyAm: 'መጋዘንዎ ወይም ሲቅዎ ውስጥ ለረጅም ጊዜ ተቀምጠው የቆዩ እና ያልተሸጡ ዕቃዎች ምን ያህል ካፒታልዎን ይዞቦታል?'),
    AdTemplateModel(groupId: 2, dayNumber: 4, bodyAm: 'አንድ እቃ ሱቅ እና መጋዘን ውስጥ ምን ያህል ብዛት እንዳለ ለማወቅ ስንት ሰዓት ይባክንብዎታል?'),
    AdTemplateModel(groupId: 2, dayNumber: 5, bodyAm: 'ቀጥታ ከመጋዘን ወይም ከሱቅ ሲሸጥ የተሸጡ እቃ ዝርዝሮች ሲያስፈልጉ እንዴት ነው ወደኋላ ተመልሰው ሁሉንም ሽያጮች ማግኘት የሚችሉት?'),
    AdTemplateModel(groupId: 2, dayNumber: 6, bodyAm: 'መጋዘንዎን እና ሱቅዎን በአንድ ጊዜ መቆጣጠር አለመቻልዎ ስራዎን አድካሚ አድርጎቦታል? ሁሉምን በአንዴ በቀላሉ የምቆጣጠርበት መንገድ ይኖር ይሆን ብለው አስበው ያውቃሉ?'),
    AdTemplateModel(groupId: 2, dayNumber: 7, bodyAm: 'መጋዘን ውስጥ መኖሩን ረስተው ሌላ ተጨማሪ ዕቃ አዘው ያውቃሉ? ገንዘብዎ ቶሎ በማይሸጡ እቃዎች ተይዞቦታል?'),
    AdTemplateModel(groupId: 2, dayNumber: 8, bodyAm: 'እያንዳንዱ እቃዎች መች እና ምን ያህል ወደ መጋዘን ወይም ወደ ሱቅ እንደገባ መች ከአንዱ ወደ አንዱ እንደተዘዋወረ ማወቅ ቢያስፈልጎዎት እንዴት ማዎቅ ይችላሉ?'),
    AdTemplateModel(groupId: 2, dayNumber: 9, bodyAm: 'መጋዘን የሚቆጣጠር ሰራተኛዎ \'እቃው የለም\' ሲልዎት፣ እርሶ ደግሞ እንዳለ እየተሰማዎት ምን ያህል ጊዜ ጥርጣሬ ውስጥ ገብተው ያውቃሉ?'),
    AdTemplateModel(groupId: 2, dayNumber: 10, bodyAm: 'የሽያጭ ሰራተኛዎ ሱቅ ውስጥ ዕቃው የለም እያለ ደንበኛ እየመለሰ ነገር ግን መጋዘን ውስጥ ያን እቃ አግኝተውት ያውቃሉ?'),
    AdTemplateModel(groupId: 2, dayNumber: 11, bodyAm: 'መጋዘን እና ሱቅን ያሉትን እቃዎች ለማረጋገጥ ገቢና ወጪን ለመስራት ሚባክንቦትን ጊዜ ስራየን ለማስፋፋት እና ለሌላ የተሻለ ስራ ብጠቀምበት ይሻላል ብለው ያውቃሉ?'),
    AdTemplateModel(groupId: 2, dayNumber: 12, bodyAm: 'መጋዘን እና ሱቅን አንድ ላይ ማስተዳደር ከባድ ነበር። አሁን ግን \'Alarm ERP\' መጥቶ ሁለቱንም በአንድ ቦታ መቆጣጠር ቀላል በማድረግ ጊዜዎን እና ወጭዎን መቀነስ ችሏል። ይሞክሩት እና ውጤቱን ይዩት።'),
    AdTemplateModel(groupId: 2, dayNumber: 13, bodyAm: 'መጋዘንዎን እና ሱቅዎን የመቆጣጠሩን ጭንቀት ለ’Alarm ERP’ ይስጡት እና እርሶ ሰላሞን እና እፎይታዎን ያግኙ'),
    
    // Group 3
    AdTemplateModel(groupId: 3, dayNumber: 1, bodyAm: 'ዛሬ ቸክ ባላደረጉት ሌላኛው ቅርንጫፍዎ ውስጥ ምን ያህል ሽያጭ እንደተካሄደ በትክክል ያውቃሉ? ወይስ ሪፖርት መጠበቅ ግዴታ ነው?'),
    AdTemplateModel(groupId: 3, dayNumber: 2, bodyAm: 'ከርቀት ሆነው ሁሉንም ሱቆች በአንዴ መቆጣጠር አለመቻልዎ ለቤተሰብዎ እና ለራሶ የሚሰጡትን ጊዜ አጥብቦቦታል?'),
    AdTemplateModel(groupId: 3, dayNumber: 3, bodyAm: 'ከአንዱ ሱቅዎ ወደ ሌላው ወይም ከመጋዘን ወደ ሱቅ የሚዘዋወረው ገንዘብ እና ዕቃ መሃል ላይ የሚባክን/የሚጠፋ ነገር እንደሌለ ምን ያህል እርግጠኛ ነዎት? ሂሳቡን ለመስራትስ የሁሉንም መረጃ በአንዴ ማግኘት ይችላሉ?'),
    AdTemplateModel(groupId: 3, dayNumber: 4, bodyAm: 'የትኛው ቅርንጫፍዎ በትክክል ትርፋማ እንደሆነ እና የትኛው ኪሳራ እያመጣብዎ እንደሆነ በዝርዝር ያውቃሉ?'),
    AdTemplateModel(groupId: 3, dayNumber: 5, bodyAm: 'አዲስ ቅርንጫፍ ለመክፈት ወይም ሌላ ስራ ለመጀመር ሲያስቡ አሁን ላለው እንኳን ሰአት እየበቃኝ አይደለም በዛ ላይ መቆጣጠሩ አስቸጋሪ እየሆነ መምጣቱ አይቀርም ብለው ያሰቡትን ሳይጀምሩ ቀርተዋል?'),
    AdTemplateModel(groupId: 3, dayNumber: 6, bodyAm: 'ዛሬ ሱቅ ባይሄዱ የተሸጡት እቃዎች በትክክለኛ ዋጋቸው እንደተሸጡ እንዴት ማወቅ ይችላሉ?'),
    AdTemplateModel(groupId: 3, dayNumber: 7, bodyAm: 'የየትኛው ሱቅዎ ሽያጭ እንደቀነሰ ለማወቅ እና የትኛው ላይ መሰራት/መስተካከል ያለ ነገር እንዳለ ለማወቅ ተቸግረዋል?'),
    AdTemplateModel(groupId: 3, dayNumber: 8, bodyAm: 'ሱቅ ውስጥ በአካል ካልተገኙ ስራው በትክክል አልሄድ ብሎ እርሶን እስረኛ አድርጎታል?'),
    AdTemplateModel(groupId: 3, dayNumber: 9, bodyAm: 'በሱቆቹ ውስጥ ያለው የጥሬ ገንዘብ (Cash) እና የስራ አካውንቶች ላይ ያለውን መጠን በትክክል በፈለጉበት ሰአት ማወቅ ይችላሉ?'),
    AdTemplateModel(groupId: 3, dayNumber: 10, bodyAm: 'ሰራተኞች እኔ ኖርኩም አልኖርኩም በአግባቡ ሲራቸውን እንዲሰሩ ምን አይነት መንገድ ብከተል ይሻላል ብለው አስበው ያውቃሉ?'),
    AdTemplateModel(groupId: 3, dayNumber: 11, bodyAm: 'ሁለተኛ ሱቅ መክፈት ገቢን መጨመር ነው ወይስ ጭንቀትን ማብዛት? እንዴትስ በቀላሉ ሁሉንም መቆጣጠር ይቻላል?'),
    AdTemplateModel(groupId: 3, dayNumber: 12, bodyAm: 'ከዚ በፊት አንድ እና ከአንድ በላይ ሱቆችን እና መጋዘንን መቆጣጠር ከባድ ነበር። አሁን ግን በ‘Alarm ERP’ ሲስተም አማካኝነት ሱቆችን፣ መጋዘኖችን፣ ዱቤ ና ብድሮችን፣ ጠቅላላ ገቢና ዎጭዎችን መቆጣጠር ቀላል ሁኗል አላርም ኢ-አር-ፒን በመጠቀም ስራዎን በማቅለል እና አላስፈላጊ ጭንቀቶችን በማስወገድ ስራዎን ያስፋፉ፣ ትርፋማ ይሁኑ።'),
    AdTemplateModel(groupId: 3, dayNumber: 13, bodyAm: 'በአካል ሳይገኙ ሁሉንም ቅርንጫፎች መቆጣጠር ይቻላል። \'Alarm ERP’ ሁሉምን የቁጥጥር ስራዎች ቀላል ያደርገዋል።'),
    
    // Group 4
    AdTemplateModel(groupId: 4, dayNumber: 1, bodyAm: 'በየወረቀቱ ተበታትኖ የተመዘገበው የደንበኞች ብድር ተደምሮ ምን ያህል እንደሆነ ያውቃሉ?'),
    AdTemplateModel(groupId: 4, dayNumber: 2, bodyAm: 'የዱቤ ደብተሩ ቢጠፋ ወይም ቢቀደድ የሰጡትን ዱቤ እንዴት ነው ማስመለስ የሚችሉት?'),
    AdTemplateModel(groupId: 4, dayNumber: 3, bodyAm: 'በወሩ መጨረሻ ምን ያህል ትርፍ አግኝተዋል ወይስ የሸጡት ገንዘብ በብድር እና ባልታወቁ ወጪዎች ጠፍቷል?'),
    AdTemplateModel(groupId: 4, dayNumber: 4, bodyAm: 'ደንበኛ "ከፈልኩ" ቢልዎት እና እርስዎ ደብተር ላይ ካልመዘገቡት እንዴት ነው ማረጋገጥ የሚችሉት?'),
    AdTemplateModel(groupId: 4, dayNumber: 5, bodyAm: 'እጅዎ ላይ ያለው ገንዘብ እና ንግድዎ ላይ ያለው ትክክለኛ ትርፍ ለይተው ያውቁታል?'),
    AdTemplateModel(groupId: 4, dayNumber: 6, bodyAm: 'የብድር አሰባሰብዎ መዘግየት አዳዲስ እቃዎችን ለመጨመር እንቅፋት ሆኖብዎታል?'),
    AdTemplateModel(groupId: 4, dayNumber: 7, bodyAm: 'በወረቀት ላይ ሂሳብ ሲሰሩ የሆነ ያህል ብር እንደ ጎደለ ተሰምቶት ያውቃል? ምን አልባት በዱቤ ምክንያት ሰው ጋር ይሆናል ብለው ገምተው ግን ለማስታወታዎስ ተቸግረውስ ያውቃሉ?'),
    AdTemplateModel(groupId: 4, dayNumber: 8, bodyAm: 'ደንበኛ የወሰደውን ብድር ቢረሳው የወሰደውን እቃ እና መች እንደወሰደ በማስረጃ ማሳየት ይችላሉ?'),
    AdTemplateModel(groupId: 4, dayNumber: 9, bodyAm: 'ትናንሽ የሚባሉ ወጪዎች ብዙም ትኩረት የማይሰጣቸው ወጭወች ተደምረው ትርፍዎን እየቀነሱት እንዳልሆነ በምን እርግጠኛ መሆን ይችላሉ?'),
    AdTemplateModel(groupId: 4, dayNumber: 10, bodyAm: 'ደንበኛው ዲቤውን በዚ ቀን እመልሳለው ብሎ ሲዎስድ እንሶ ቀኑን እየረሱት ተቸግረዋል?'),
    AdTemplateModel(groupId: 4, dayNumber: 11, bodyAm: 'የሆነ ደንበኛ የወሰደውን ብድር ለማዎቅ የሽያጭ እና የብድር ደብተሮችን ማገላበጥ አሰልች ሁኖቦታል?'),
    AdTemplateModel(groupId: 4, dayNumber: 12, bodyAm: 'ብድር እና ወጪዬን መቆጣጠር አድካሚ ነበር። አሁን ግን \'Alarm Stock and ERP’ ሁሉንም ነገር በቀጥታ እና በቀላሉ እንዲቆጣጠሩ በማድረግ ስራዎን ቀላል፣ ከአላስፈላጊ ወጪ ነጻ እና ትርፋማ ሊያደርግልዎ መጧል'),
    AdTemplateModel(groupId: 4, dayNumber: 13, bodyAm: 'ብድር እና ወጪ መቆጣጠር ትልቅ ፈተና ነበር። \'Alarm Stock and ERP’ ግን ሁሉንም ቀላል በማድረግ ወጭዎን እና ትርፎን በቀጥታ ያሳይዎታል'),
  ];
}
