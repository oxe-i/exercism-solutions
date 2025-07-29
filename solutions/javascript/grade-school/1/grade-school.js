export class GradeSchool {
  #studentToGrade;
  #gradeToStudents;

  #binSearch(crtList, student) {
    let low = 0;
    let high = crtList.length - 1
      
    while (low <= high) {
      const mid = (low + high) >> 1
      const comparison = crtList[mid].localeCompare(student);
      switch (comparison) {
        case -1:
          low = mid + 1;
          continue;
        case 1:
          high = mid - 1;
          continue;
        default:
          crtList.splice(mid, 1);
          return false;
      }
    }

    crtList.splice(low, 0, student);
    return true;
  }

  constructor() {
    this.#studentToGrade = new Map();
    this.#gradeToStudents = new Map();
  }
  
  roster() {
    return this.#gradeToStudents.entries().reduce((acc, [grade, students]) => {
      acc[grade] = students.map(student => student);
      return acc;
    }, {});
  }

  add(student, grade) {
    const prevGrade = this.#studentToGrade.get(student);
    if (prevGrade) {
      const prevList = this.#gradeToStudents.get(prevGrade);
      prevList.splice(prevList.indexOf(student), 1);
    }
    this.#studentToGrade.set(student, grade);
    const crtList = this.#gradeToStudents.get(grade);
    if (crtList) {
      this.#binSearch(crtList, student);      
      return;
    }
    this.#gradeToStudents.set(grade, [student]);
  }

  grade(val) {
    return (this.#gradeToStudents.get(val) ?? []).map(student => student);
  }
}
