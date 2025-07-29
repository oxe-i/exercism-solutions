function idxToDay(idx){
  switch (idx) {
    case 0: return "Sunday";
    case 1: return "Monday";
    case 2: return "Tuesday";
    case 3: return "Wednesday";
    case 4: return "Thursday";
    case 5: return "Friday";
    case 6: return "Saturday";
    default: return undefined;
  }
}

function isTeenthDay(date) {
  const day = date.getDate();
  return day >= 13 && day <= 19;
}

function isWeekDay(date, weekday) {
  return idxToDay(date.getDay()) === weekday;
}

export const meetup = (year, month, value, weekday) => {
  const weekdays = [];
  for (let day = 1; day <= 31; ++day) {
    const crtDate = new Date(year, month - 1, day);    
    if (crtDate.getFullYear() != year || crtDate.getMonth() != month - 1) break;
    if (isWeekDay(crtDate, weekday)) weekdays.push(crtDate);
  }  
  switch (value) {
    case "first": return weekdays[0];
    case "second": return weekdays[1];
    case "third": return weekdays[2];
    case "fourth": return weekdays[3];
    case "last": return weekdays.at(-1);
    case "teenth": return weekdays.find(isTeenthDay);
  }
};
