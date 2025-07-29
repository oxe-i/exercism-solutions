export class Clock {
  hours;
  minutes;

  #rollOver(hours, minutes) {
    const remMinutes = ((minutes % 60) + 60) % 60;
    const addToHours = Math.floor(minutes / 60);
    const remHours = (((hours + addToHours) % 24) + 24) % 24;
    return [remHours, remMinutes];
  }
  
  constructor(hours, minutes) {
    [this.hours, this.minutes] = this.#rollOver(hours ?? 0, minutes ?? 0);
  }

  toString() {
    const hourStr = String(this.hours).padStart(2, "0");
    const minuteStr = String(this.minutes).padStart(2, "0");
    return `${hourStr}:${minuteStr}`;
  }

  plus(minutes) {
    return new Clock(this.hours, this.minutes + minutes);
  }

  minus(minutes) {
    return new Clock(this.hours, this.minutes - minutes);
  }

  equals(another) {
    return this.hours == another.hours && this.minutes == another.minutes;
  }
}
