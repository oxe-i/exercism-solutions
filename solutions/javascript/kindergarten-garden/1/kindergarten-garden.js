const DEFAULT_STUDENTS = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eve',
  'Fred',
  'Ginny',
  'Harriet',
  'Ileana',
  'Joseph',
  'Kincaid',
  'Larry',
];

const PLANT_CODES = {
  G: 'grass',
  V: 'violets',
  R: 'radishes',
  C: 'clover',
};

export class Garden {
  #map;
  
  #recurSplit(iter, n) {
    if (!iter.length) return [];
    return [iter.slice(0, n), ...this.#recurSplit(iter.slice(n), n)];
  }
  
  constructor(diagram, students = DEFAULT_STUDENTS) {
    const plants = diagram.split(/\s/).map(row => [...row].map(plant => PLANT_CODES[plant]));
    const splitRows = plants.map(row => this.#recurSplit(row, 2));
    const sortedStudents = students.sort((a, b) => a.localeCompare(b));
    const mapStudentToPlants = sortedStudents.map((student, idx) => {
      return [student, [...(splitRows?.[0]?.[idx] ?? []), ...(splitRows?.[1]?.[idx] ?? [])]];
    });
    this.#map = new Map(mapStudentToPlants);
  }

  plants(student) {
    return this.#map.get(student);
  }
}
