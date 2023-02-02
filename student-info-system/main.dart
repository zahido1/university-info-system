import 'dart:io';

num totalCalculator(var course){
  num sum = course['midterm'] * 0.4 + course['quiz'] * 0.1 + course['finalExam'] * 0.5;
  return sum;
}

String totalChecker(var course){
  String value;

  if(course['total']>=61 && course['total']<71){
    value = "D";
  }
  else if(course['total']>=71 && course['total']<81){
    value = "C";
  }
  else if(course['total']>=81 && course['total']<91){
    value = "B";
  }
  else if(course['total']>=91){
    value = "A";
  }
  else{
    value = "F";
  }

  if(course['finalExam']<61){
    value = "F";
  }

  return value;
}

num totalCreditCalculator(course_sem){
  num creditSum = 0;
  for(var course in course_sem){
    creditSum += course['credit'];
  }
  return creditSum;
}

num gpaCalculator(course_sem){
  num gpa = 0;
  for(var course in course_sem){
    gpa += course['credit']*course['total'];
  }
  
  gpa /= totalCreditCalculator(course_sem);
  return gpa;
}

void main(){
  String validStudentID = "123123123";
  String validPassword = "1234";
  String studentName = "Zahid Abdullayev";
  DateTime birthDay = DateTime(2004,1,1);
  num annualFee = 4500;
  String educationForm = "Eyani";
  bool presidentalScholar = false;

  var course1 = {'name':'English-1','credit':20, 'midterm':80, 'quiz':75, 'finalExam':86};
  course1['total'] = totalCalculator(course1);
  course1['value'] = totalChecker(course1);


  var course2 = {'name':'Physics-1','credit':8, 'midterm':90, 'quiz':80, 'finalExam':76};
  course2['total'] = totalCalculator(course2);
  course2['value'] = totalChecker(course2);


  var course3 = {'name':'English-2','credit':20, 'midterm':100, 'quiz':50, 'finalExam':42};
  course3['total'] = totalCalculator(course3);
  course3['value'] = totalChecker(course3);

  var course4 = {'name':'Calculus-1','credit':6, 'midterm':100, 'quiz':40, 'finalExam':92};
  course4['total'] = totalCalculator(course4);
  course4['value'] = totalChecker(course4);

  var course5 = {'name':'Physics-2','credit':8, 'midterm':32, 'quiz':62, 'finalExam':61};
  course5['total'] = totalCalculator(course5);
  course5['value'] = totalChecker(course5);

  var sem1_courses = [course1, course2];
  var sem2_courses = [course3, course4, course5];

  print("Xosh gelmisiniz. Sisteme daxil olmaq uchun zehmet olmasa telebe kartinizin nomresini ve parolunuzu daxil edin:");
  String? studentID = (stdin.readLineSync()!);
  String? password = (stdin.readLineSync()!);

  if((studentID == validStudentID) && (password == validPassword)){
    print("Sechin:\n1. Telebenin shexsi melumatlari.\n2. Qiymet cedveli.\n");
    String? choice1 = stdin.readLineSync();
    switch (choice1) {
      case "1":
        print("Telebenin adi soyadi: $studentName\nDoguldugu il: ${birthDay.day}.${birthDay.month}.${birthDay.year}\nTehsilin formasi: $educationForm\nIllik tehsil haqqi: $annualFee AZN\nPrezident teqaudcusu: ${presidentalScholar==true? "Beli": "Xeyr"}");
        print("Ortalama:${(gpaCalculator(sem1_courses)*totalCreditCalculator(sem1_courses) + gpaCalculator(sem2_courses)*totalCreditCalculator(sem2_courses))/(totalCreditCalculator(sem2_courses)+totalCreditCalculator(sem2_courses))}");
        break;
      case "2":
        print("Nechenci semestrin qiymet cedveline baxmaq isteyirsiniz?");
        String? choice2 = stdin.readLineSync();
        switch (choice2){
          case "1":
            print("Fenn:\t\tKredit:\tMidterm: Quiz:\tFinal:\tUmumi:\tQiymet:\n");
            for(var course in sem1_courses){
              for(var key in course.keys){
                stdout.write(course[key]);
                stdout.write('\t');
            }
            stdout.write('\n');
            }
            stdout.write('\nGPA: ${gpaCalculator(sem1_courses)}');
            break;
          case "2":
            print("Fenn:\t\tKredit:\tMidterm: Quiz:\tFinal:\tUmumi:\tQiymet:\n");
            for(var course in sem2_courses){
              for(var key in course.keys){
                stdout.write(course[key]);
                stdout.write('\t');
            }
            stdout.write('\n');
            }
            stdout.write('\nGPA: ${gpaCalculator(sem2_courses)}');
            break;
          default:
            print("Daxil edilen semestri hal-hazirda davam etdirmir ve ya bitirmemisiniz.");
        }
        break;
      default:
        print("Qeyd edilen emeliyyat movcud deyildir!");
    }
  }
  else{
    print("\nTelebe kartinizin nomresini ve ya parolunuzu yanlis daxil etmisiniz!\n============================\nZehmet olmasa melumatin dogurluguna diqqet yetirib yeniden daxil edin.");
    main();
  }
}